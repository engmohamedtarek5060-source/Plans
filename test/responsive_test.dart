import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/core/responsive/responsive.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/role/presentation/screens/role_selection_screen.dart';

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
      overrides: [
        apiServiceProvider.overrideWithValue(deps.apiService),
        roleStorageProvider.overrideWithValue(deps.roleStorage),
        settingsStorageProvider.overrideWithValue(deps.settingsStorage),
      ],
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

/// Pumps the app at [size] and returns any RenderFlex overflows seen during
/// layout, which otherwise only surface as console noise.
Future<List<String>> _pumpAppAtSize(
  WidgetTester tester,
  String label,
  Size size,
  AppDependencies deps,
) async {
  final overflows = <String>[];
  final previousOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('overflowed')) {
      overflows.add('$label: ${details.exceptionAsString()}');
    }
    previousOnError?.call(details);
  };

  // Constant ratio so the logical size equals `size`.
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(_app(deps));
  await tester.pumpAndSettle();

  FlutterError.onError = previousOnError;
  return overflows;
}

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

  group('Role selection screen renders without overflow at every size', () {
    for (final entry in _sizes.entries) {
      testWidgets(entry.key, (tester) async {
        // Empty store: no role chosen, which is what puts the selection screen
        // in front of the login screen on a first launch.
        final deps = AppDependencies.create(store: _InMemoryStore());
        final overflows =
            await _pumpAppAtSize(tester, entry.key, entry.value, deps);

        expect(find.byType(RoleSelectionScreen), findsOneWidget,
            reason: 'role selection should render at ${entry.key}');
        expect(overflows, isEmpty, reason: overflows.join('\n'));
      });
    }
  });

  group('Login screen renders without overflow at every size', () {
    for (final entry in _sizes.entries) {
      testWidgets(entry.key, (tester) async {
        // A role is already chosen, so the gate falls through to the session
        // check and — with no token — the login screen.
        final store = _InMemoryStore();
        await store.write(key: 'plans.role', value: 'company');

        final deps = AppDependencies.create(store: store);
        final overflows =
            await _pumpAppAtSize(tester, entry.key, entry.value, deps);

        expect(find.byType(LoginScreen), findsOneWidget,
            reason: 'login should render at ${entry.key}');
        expect(overflows, isEmpty, reason: overflows.join('\n'));
      });
    }
  });
}
