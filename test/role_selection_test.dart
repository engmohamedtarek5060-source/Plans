import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/core/storage/role_storage.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/presentation/controllers/role_controller.dart';
import 'package:saudiaaaa/features/role/presentation/controllers/role_selection_controller.dart';

class _InMemoryStore implements SecureKeyValueStore {
  final values = <String, String>{};

  @override
  Future<String?> read({required String key}) async => values[key];

  @override
  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({required String key}) async => values.remove(key);
}

/// Stands in for platform storage being unavailable or locked.
class _ThrowingStore implements SecureKeyValueStore {
  @override
  Future<String?> read({required String key}) async => throw Exception('boom');

  @override
  Future<void> write({required String key, required String? value}) async =>
      throw Exception('boom');

  @override
  Future<void> delete({required String key}) async => throw Exception('boom');
}

ProviderContainer _container(SecureKeyValueStore store) {
  final container = ProviderContainer(
    overrides: [
      roleStorageProvider.overrideWithValue(RoleStorage(store: store)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('UserRole.fromStorage', () {
    test('parses the persisted values', () {
      expect(UserRole.fromStorage('client'), UserRole.client);
      expect(UserRole.fromStorage('company'), UserRole.company);
    });

    test('treats null, empty and unknown values as "not chosen"', () {
      expect(UserRole.fromStorage(null), isNull);
      expect(UserRole.fromStorage(''), isNull);
      expect(UserRole.fromStorage('  '), isNull);
      expect(UserRole.fromStorage('CLIENT'), isNull);
      expect(UserRole.fromStorage('owner'), isNull);
    });
  });

  group('RoleController', () {
    test('resolves to null when nothing is stored', () async {
      final container = _container(_InMemoryStore());

      expect(await container.read(roleControllerProvider.future), isNull);
    });

    test('resolves to the stored role on a later launch', () async {
      final store = _InMemoryStore()..values['plans.role'] = 'company';
      final container = _container(store);

      expect(
        await container.read(roleControllerProvider.future),
        UserRole.company,
      );
    });

    test('setRole persists under the shared key and publishes the role',
        () async {
      final store = _InMemoryStore();
      final container = _container(store);
      await container.read(roleControllerProvider.future);

      await container.read(roleControllerProvider.notifier)
          .setRole(UserRole.client);

      expect(store.values['plans.role'], 'tenant-user');
      expect(container.read(roleControllerProvider).value, UserRole.client);
    });

    test('clear forgets the choice so the next launch asks again', () async {
      final store = _InMemoryStore()..values['plans.role'] = 'client';
      final container = _container(store);
      await container.read(roleControllerProvider.future);

      await container.read(roleControllerProvider.notifier).clear();

      expect(store.values.containsKey('plans.role'), isFalse);
      expect(container.read(roleControllerProvider).value, isNull);
    });

    test('an unreadable store degrades to "not chosen" rather than throwing',
        () async {
      final container = _container(_ThrowingStore());

      expect(await container.read(roleControllerProvider.future), isNull);
    });
  });

  group('RoleSelectionController', () {
    test('Continue is disabled until a role is picked', () {
      final container = _container(_InMemoryStore());

      expect(container.read(roleSelectionControllerProvider).canContinue, isFalse);

      container
          .read(roleSelectionControllerProvider.notifier)
          .select(UserRole.client);

      final state = container.read(roleSelectionControllerProvider);
      expect(state.canContinue, isTrue);
      expect(state.isSelected(UserRole.client), isTrue);
      expect(state.isSelected(UserRole.company), isFalse);
    });

    test('selecting the other option moves the highlight', () {
      final container = _container(_InMemoryStore());
      final controller =
          container.read(roleSelectionControllerProvider.notifier);

      controller.select(UserRole.client);
      controller.select(UserRole.company);

      final state = container.read(roleSelectionControllerProvider);
      expect(state.isSelected(UserRole.company), isTrue);
      expect(state.isSelected(UserRole.client), isFalse);
    });

    test('confirm persists the choice and hands it to the app-wide role',
        () async {
      final store = _InMemoryStore();
      final container = _container(store);
      // Mirrors the real flow: the gate resolves the role before the selection
      // screen is ever built.
      await container.read(roleControllerProvider.future);

      final controller =
          container.read(roleSelectionControllerProvider.notifier);
      controller.select(UserRole.company);
      await controller.confirm();

      expect(store.values['plans.role'], 'tenant-admin');
      expect(container.read(roleControllerProvider).value, UserRole.company);
    });

    test('confirm without a selection is a no-op', () async {
      final store = _InMemoryStore();
      final container = _container(store);
      await container.read(roleControllerProvider.future);

      await container.read(roleSelectionControllerProvider.notifier).confirm();

      expect(store.values, isEmpty);
      expect(container.read(roleControllerProvider).value, isNull);
    });

    test('a write failure still lets the user into the app for this run',
        () async {
      // RoleStorage swallows write failures the way TokenStorage does, so the
      // role holds in memory and only the next cold start re-asks.
      final container = _container(_ThrowingStore());
      await container.read(roleControllerProvider.future);

      final controller =
          container.read(roleSelectionControllerProvider.notifier);
      controller.select(UserRole.client);
      await controller.confirm();

      expect(container.read(roleControllerProvider).value, UserRole.client);
      expect(container.read(roleSelectionControllerProvider).hasError, isFalse);
    });
  });
}
