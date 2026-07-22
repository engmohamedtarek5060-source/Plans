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

/// A role is already chosen, so the root gate falls through to the session
/// check instead of stopping at the selection screen.
Map<String, String> get _withRoleChosen => {'plans.role': 'company'};

void main() {
  testWidgets('shows the role selection screen on a first launch',
      (WidgetTester tester) async {
    final dependencies =
        AppDependencies.create(store: _InMemorySecureStore());

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pumpAndSettle();

    expect(find.byType(RoleSelectionScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('shows the login screen when there is no stored session',
      (WidgetTester tester) async {
    final dependencies =
        AppDependencies.create(store: _InMemorySecureStore(_withRoleChosen));

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(MainShellScreen), findsNothing);
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('startup never strands the user on the splash when role storage '
      'hangs', (WidgetTester tester) async {
    // Nothing answers, standing in for a wedged platform channel.
    final dependencies = AppDependencies.create(store: _HangingStore());

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pump();

    // Splash while the stored role is still being resolved.
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    expect(find.byType(RoleSelectionScreen), findsNothing);

    // Past the read timeout the app must fall through to asking the user.
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();

    expect(find.byType(RoleSelectionScreen), findsOneWidget);

    // Drain the session bootstrap timeout too, so the test doesn't end with a
    // pending timer from the auth cubit still running behind the gate.
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
  });

  testWidgets('startup never strands the user on the splash when session '
      'storage hangs', (WidgetTester tester) async {
    // The role resolves, the session read never does.
    final dependencies =
        AppDependencies.create(store: _HangingStore(_withRoleChosen));

    await tester.pumpWidget(_buildApp(dependencies));
    await tester.pump();

    // findsWidgets, not findsOneWidget: the role resolves immediately here, so
    // this frame catches the gate cross-fading one splash into the next.
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    expect(find.byType(LoginScreen), findsNothing);

    // Past the bootstrap timeout the app must fall through to login.
    await tester.pump(const Duration(seconds: 11));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}

/// Answers only the seeded keys; every other read stalls forever.
class _HangingStore implements SecureKeyValueStore {
  _HangingStore([Map<String, String>? answers]) : _answers = {...?answers};

  final Map<String, String> _answers;

  @override
  Future<String?> read({required String key}) {
    if (_answers.containsKey(key)) return Future<String?>.value(_answers[key]);
    return Completer<String?>().future;
  }

  @override
  Future<void> write({required String key, required String? value}) async {}

  @override
  Future<void> delete({required String key}) async {}
}
