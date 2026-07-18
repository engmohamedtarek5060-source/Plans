import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/shell/presentation/screens/main_shell_screen.dart';

/// Session storage stand-in: platform secure storage has no implementation
/// under `flutter test`, and its method channel never replies inside the
/// fake-async zone `testWidgets` runs in.
class _InMemorySecureStore implements SecureKeyValueStore {
  _InMemorySecureStore([Map<String, String>? seed])
      : _values = {...?seed};

  final Map<String, String> _values;

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

Widget _buildApp(AppDependencies dependencies) => ProviderScope(
      overrides: [
        apiServiceProvider.overrideWithValue(dependencies.apiService),
      ],
      child: AppBlocProviders(
        dependencies: dependencies,
        child: const PlansApp(),
      ),
    );

void main() {
  testWidgets('shows the login screen when there is no stored session',
      (WidgetTester tester) async {
    final dependencies =
        AppDependencies.create(store: _InMemorySecureStore());

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(MainShellScreen), findsNothing);
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('startup never strands the user on the splash when storage hangs',
      (WidgetTester tester) async {
    // A store that never answers stands in for a wedged platform channel.
    final dependencies = AppDependencies.create(store: _HangingStore());

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pump();

    // Splash while the session is still being resolved.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Past the bootstrap timeout the app must fall through to login.
    await tester.pump(const Duration(seconds: 11));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

/// Never completes — simulates secure storage stalling forever.
class _HangingStore implements SecureKeyValueStore {
  @override
  Future<String?> read({required String key}) => Completer<String?>().future;

  @override
  Future<void> write({required String key, required String? value}) async {}

  @override
  Future<void> delete({required String key}) async {}
}
