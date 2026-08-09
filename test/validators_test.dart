import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('accepts ordinary addresses', () {
      const valid = [
        'name@company.com',
        'first.last@company.co.uk',
        'user+tag@sub.domain.org',
        'user_name@example-site.com',
        "o'brien@example.com",
        'claude.devtest+flutter@example.com',
      ];

      for (final address in valid) {
        expect(
          Validators.email(address, isArabic: false),
          isNull,
          reason: '$address should be accepted',
        );
      }
    });

    test('rejects the shapes the old contains-@ check let through', () {
      // Each of these passed the previous validator and would have produced a
      // request that could only fail.
      const invalid = ['@', 'a@', '@b', 'a@b', 'name@company', 'a b@test.com'];

      for (final address in invalid) {
        expect(
          Validators.email(address, isArabic: false),
          isNotNull,
          reason: '$address should be rejected',
        );
      }
    });

    test('reports an empty value as missing, not malformed', () {
      expect(Validators.email(null, isArabic: false), 'Enter your email');
      expect(Validators.email('   ', isArabic: false), 'Enter your email');
      expect(
        Validators.email('nope', isArabic: false),
        'Enter a valid email address',
      );
    });

    test('tolerates surrounding whitespace, as the repository trims too', () {
      expect(Validators.email('  name@company.com  ', isArabic: false), isNull);
    });

    test('localizes its messages', () {
      expect(Validators.email('', isArabic: true), 'أدخل البريد الإلكتروني');
      expect(
        Validators.email('nope', isArabic: true),
        'بريد إلكتروني غير صالح',
      );
    });
  });

  group('Validators.password', () {
    test('accepts any non-empty value', () {
      expect(Validators.password('secure1', isArabic: false), isNull);
      expect(Validators.password('كلمة123', isArabic: true), isNull);
      // No length or complexity rule at sign-in: an older account whose
      // password predates the current policy must still be able to log in.
      expect(Validators.password('short', isArabic: false), isNull);
      expect(Validators.password('abcdef', isArabic: false), isNull);
      expect(Validators.password('123456', isArabic: false), isNull);
      // Whitespace is not trimmed — a password may legitimately contain it.
      expect(Validators.password(' ', isArabic: false), isNull);
    });

    test('rejects an empty value', () {
      expect(Validators.password(null, isArabic: false), 'Enter your password');
      expect(Validators.password('', isArabic: false), 'Enter your password');
      expect(Validators.password('', isArabic: true), 'أدخل كلمة المرور');
    });
  });

  group('Validators.newPassword', () {
    test('enforces the backend minimum of 6 characters', () {
      // The server answers `password must be longer than or equal to 6
      // characters`; checking here saves a round trip.
      expect(Validators.minPasswordLength, 6);
      expect(
        Validators.newPassword('12345', isArabic: false),
        'Password must be at least 6 characters',
      );
      expect(Validators.newPassword('abc123', isArabic: false), isNull);
    });

    test('requires both letters and numbers', () {
      expect(
        Validators.newPassword('123456', isArabic: false),
        'Password must contain letters and numbers',
      );
      expect(
        Validators.newPassword('abcdef', isArabic: false),
        'Password must contain letters and numbers',
      );
      expect(Validators.newPassword('كلمة123', isArabic: true), isNull);
    });

    test('reports an empty value as missing, not too short', () {
      expect(
        Validators.newPassword('', isArabic: false),
        'Enter your password',
      );
    });
  });

  group('Validators.confirmPassword', () {
    test('accepts an exact match', () {
      expect(
        Validators.confirmPassword(
          'hunter22',
          original: 'hunter22',
          isArabic: false,
        ),
        isNull,
      );
    });

    test('rejects a mismatch', () {
      expect(
        Validators.confirmPassword(
          'hunter23',
          original: 'hunter22',
          isArabic: false,
        ),
        'Passwords do not match',
      );
    });

    test('does not trim — whitespace is part of a password', () {
      // Matching these would let someone register with a password they cannot
      // reproduce on the login screen.
      expect(
        Validators.confirmPassword(
          'hunter22 ',
          original: 'hunter22',
          isArabic: false,
        ),
        'Passwords do not match',
      );
    });

    test('reports an empty confirmation as missing', () {
      expect(
        Validators.confirmPassword('', original: 'x', isArabic: false),
        'Re-enter your password',
      );
    });
  });

  group('Validators.requiredText', () {
    test('accepts names with spaces, apostrophes and non-Latin scripts', () {
      const names = ['Jane Doe', "O'Brien", 'محمد أحمد', 'Al-Rajhi'];
      for (final name in names) {
        expect(
          Validators.requiredText(name, message: 'required'),
          isNull,
          reason: '$name should be accepted',
        );
      }
    });

    test('rejects empty and whitespace-only values', () {
      expect(Validators.requiredText(null, message: 'required'), 'required');
      expect(Validators.requiredText('   ', message: 'required'), 'required');
      expect(Validators.requiredText('a', message: 'required'), 'required');
    });
  });

  group('Validators.name', () {
    test('accepts Latin and Arabic names', () {
      expect(Validators.name('Jane Doe', isArabic: false), isNull);
      expect(Validators.name('محمد أحمد', isArabic: true), isNull);
    });

    test('rejects missing and numbers-only names', () {
      expect(Validators.name('', isArabic: false), 'Enter your name');
      expect(
        Validators.name('12345', isArabic: false),
        'Name must contain at least one letter',
      );
    });
  });
}
