import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/core/responsive/responsive.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';

/// In-memory secure storage stand-in (platform storage is unavailable under
/// `flutter test`).
class _InMemoryStore implements SecureKeyValueStore {
  final _values = <String, String>{};

  @override
  Future<String?> read({required String key}) async => _values[key];

  @override
  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }

  @override
  Future<void> delete({required String key}) async => _values.remove(key);
}

Widget _app(AppDependencies deps) => ProviderScope(
      overrides: [apiServiceProvider.overrideWithValue(deps.apiService)],
      child: AppBlocProviders(
        dependencies: deps,
        child: const PlansApp(),
      ),
    );

/// A representative set of window sizes: small phone, common phone, phone
/// landscape, small tablet, and large tablet.
const _sizes = <String, Size>{
  'small phone': Size(360, 640),
  'common phone': Size(411, 915),
  'phone landscape': Size(915, 411),
  'small tablet': Size(600, 960),
  'large tablet': Size(840, 1120),
};

void main() {
  group('Responsive helper', () {
    test('classifies widths into the right size bucket', () {
      expect(Responsive.sizeOf(360), ScreenSize.compact);
      expect(Responsive.sizeOf(599), ScreenSize.compact);
      expect(Responsive.sizeOf(600), ScreenSize.medium);
      expect(Responsive.sizeOf(840), ScreenSize.expanded);
    });

    test('grid columns grow with width', () {
      expect(Responsive.gridColumns(360), 1);
      expect(Responsive.gridColumns(600), 2);
      expect(Responsive.gridColumns(840), 3);
      expect(Responsive.gridColumns(1200), 4);
    });
  });

  group('Login screen renders without overflow at every size', () {
    for (final entry in _sizes.entries) {
      testWidgets(entry.key, (tester) async {
        // Any RenderFlex overflow reports as a FlutterError during layout;
        // capture it so the test fails loudly if a size breaks.
        final overflows = <String>[];
        final previousOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          if (details.exceptionAsString().contains('overflowed')) {
            overflows.add('${entry.key}: ${details.exceptionAsString()}');
          }
          previousOnError?.call(details);
        };

        tester.view.physicalSize = entry.value * tester.view.devicePixelRatio;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        // Constant ratio so the logical size equals entry.value.
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = entry.value;

        final deps = AppDependencies.create(store: _InMemoryStore());
        await tester.pumpWidget(_app(deps));
        await tester.pumpAndSettle();

        FlutterError.onError = previousOnError;

        expect(find.byType(LoginScreen), findsOneWidget,
            reason: 'login should render at ${entry.key}');
        expect(overflows, isEmpty, reason: overflows.join('\n'));
      });
    }
  });
}
