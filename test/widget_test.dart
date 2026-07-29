import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/app.dart';
import 'package:saudiaaaa/core/di/app_bloc_providers.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/login_screen.dart';
import 'package:saudiaaaa/features/role/presentation/screens/role_selection_screen.dart';
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
        roleStorageProvider.overrideWithValue(dependencies.roleStorage),
        settingsStorageProvider.overrideWithValue(dependencies.settingsStorage),
      ],
      child: AppBlocProviders(
        dependencies: dependencies,
        child: const PlansApp(),
      ),
    );

void main() {
  testWidgets('shows the login screen on a first launch after the splash',
      (WidgetTester tester) async {
    final dependencies =
        AppDependencies.create(store: _InMemorySecureStore());

    await tester.pumpWidget(_buildApp(dependencies));
    // Past the branded intro splash (2.8s) and any auth bootstrap.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(RoleSelectionScreen), findsNothing);
    expect(find.byType(MainShellScreen), findsNothing);
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('startup never strands the user on the splash when session '
      'storage hangs', (WidgetTester tester) async {
    final dependencies = AppDependencies.create(store: _HangingStore());

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pump();

    // Intro splash is still running on the first frame.
    expect(find.byType(LoginScreen), findsNothing);

    // Past intro + auth bootstrap timeout → login.
    await tester.pump(const Duration(seconds: 14));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(RoleSelectionScreen), findsNothing);
  });
}

/// Every read stalls forever — stands in for a wedged platform channel.
class _HangingStore implements SecureKeyValueStore {
  @override
  Future<String?> read({required String key}) => Completer<String?>().future;

  @override
  Future<void> write({required String key, required String? value}) async {}

  @override
  Future<void> delete({required String key}) async {}
}
