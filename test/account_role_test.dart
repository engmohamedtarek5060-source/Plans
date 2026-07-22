import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/storage/role_storage.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
import 'package:saudiaaaa/features/auth/domain/entities/account_role.dart';
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/role/data/repositories/role_repository_impl.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';

class _InMemoryStore implements SecureKeyValueStore {
  _InMemoryStore([Map<String, String>? seed]) : values = {...?seed};

  final Map<String, String> values;

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

AuthUser _userWithRole(String role) => AuthUser(
      id: '1',
      email: 'a@b.com',
      fullName: 'Test',
      fullNameAr: 'Test',
      role: role,
    );

void main() {
  group('AccountRole', () {
    test('parses every value the backend validates against', () {
      // The exact enum from `POST /api/users`:
      // "role must be one of the following values: ADMIN, MANAGER,
      //  ACCOUNTANT, HR, SALES, SUPPORT, USER"
      const backendEnum = [
        'ADMIN',
        'MANAGER',
        'ACCOUNTANT',
        'HR',
        'SALES',
        'SUPPORT',
        'USER',
      ];

      expect(
        AccountRole.values.map((r) => r.apiValue),
        containsAll(backendEnum),
        reason: 'every backend role must be modelled',
      );
      expect(
        AccountRole.values,
        hasLength(backendEnum.length),
        reason: 'no invented roles',
      );

      for (final value in backendEnum) {
        expect(AccountRole.fromApi(value).apiValue, value);
      }
    });

    test('is case-insensitive and tolerates whitespace', () {
      expect(AccountRole.fromApi('admin'), AccountRole.admin);
      expect(AccountRole.fromApi('  Admin  '), AccountRole.admin);
    });

    test('falls back to the least-privileged role for unknown input', () {
      // A role added server-side later must not strand the client.
      expect(AccountRole.fromApi('SUPERUSER'), AccountRole.user);
      expect(AccountRole.fromApi(null), AccountRole.user);
      expect(AccountRole.fromApi(''), AccountRole.user);
    });

    test('routes every company-side role to the company dashboard', () {
      for (final role in AccountRole.values) {
        expect(
          role.isCompanyStaff,
          role != AccountRole.user,
          reason: '$role should ${role == AccountRole.user ? "not " : ""}'
              'be company staff',
        );
      }
    });
  });

  group('AuthUser.accountRole', () {
    test('derives the destination from the server role, not a local choice',
        () {
      expect(_userWithRole('ADMIN').accountRole.isCompanyStaff, isTrue);
      expect(_userWithRole('ACCOUNTANT').accountRole.isCompanyStaff, isTrue);
      expect(_userWithRole('USER').accountRole.isCompanyStaff, isFalse);
    });
  });

  group('UserRole storage migration', () {
    test('reads the current tenant-* values', () {
      expect(UserRole.fromStorage('tenant-user'), UserRole.client);
      expect(UserRole.fromStorage('tenant-admin'), UserRole.company);
    });

    test('still reads the pre-rename values', () {
      // Devices that onboarded before the rename must not be pushed back
      // through role selection by an app update.
      expect(UserRole.fromStorage('client'), UserRole.client);
      expect(UserRole.fromStorage('company'), UserRole.company);
    });

    test('rejects unknown, empty and null values', () {
      expect(UserRole.fromStorage(null), isNull);
      expect(UserRole.fromStorage(''), isNull);
      expect(UserRole.fromStorage('  '), isNull);
      expect(UserRole.fromStorage('TENANT-ADMIN'), isNull);
      expect(UserRole.fromStorage('tenant-owner'), isNull);
    });

    test('writes only the current value', () async {
      final store = _InMemoryStore();
      final repository = RoleRepositoryImpl(RoleStorage(store: store));

      await repository.saveRole(UserRole.company);

      expect(store.values['plans.role'], 'tenant-admin');
    });

    test('rewrites a legacy value in place on read', () async {
      final store = _InMemoryStore({'plans.role': 'company'});
      final repository = RoleRepositoryImpl(RoleStorage(store: store));

      expect(await repository.getSavedRole(), UserRole.company);
      // Migrated, so the legacy form disappears from storage.
      expect(store.values['plans.role'], 'tenant-admin');
    });

    test('leaves a current value untouched on read', () async {
      final store = _InMemoryStore({'plans.role': 'tenant-user'});
      final repository = RoleRepositoryImpl(RoleStorage(store: store));

      expect(await repository.getSavedRole(), UserRole.client);
      expect(store.values['plans.role'], 'tenant-user');
    });

    test('a failed migration write still resolves the role', () async {
      // Reads keep accepting both forms, so a keystore that rejects the
      // rewrite costs nothing but a retry on the next launch.
      final repository = RoleRepositoryImpl(
        RoleStorage(store: _ReadOnlyStore({'plans.role': 'client'})),
      );

      expect(await repository.getSavedRole(), UserRole.client);
    });
  });
}

/// Answers reads but fails every write.
class _ReadOnlyStore implements SecureKeyValueStore {
  _ReadOnlyStore(this._values);

  final Map<String, String> _values;

  @override
  Future<String?> read({required String key}) async => _values[key];

  @override
  Future<void> write({required String key, required String? value}) async =>
      throw StateError('read-only');

  @override
  Future<void> delete({required String key}) async =>
      throw StateError('read-only');
}
