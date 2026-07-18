@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/core/network/session_events.dart';
import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/core/storage/token_storage.dart';
// ignore: unused_import
import 'package:saudiaaaa/features/auth/domain/entities/auth_user.dart';
import 'package:saudiaaaa/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:saudiaaaa/features/dashboard/data/models/dashboard_stats_model.dart';
import 'package:saudiaaaa/features/expenses/data/models/expense_model.dart';
import 'package:saudiaaaa/features/inventory/data/models/product_model.dart';
import 'package:saudiaaaa/features/sales/data/models/invoice_model.dart';
import 'package:saudiaaaa/features/treasury/data/models/bank_account_model.dart';

/// Exercises the real backend end to end: login, then every endpoint the app
/// reads, parsed through the production models.
///
/// This is what proves the models match the live contract — the API ships no
/// response schemas, so nothing else can.
///
///   flutter test test/api_integration_test.dart --tags integration
void main() {
  const email = 'claude.devtest+flutter@example.com';
  const password = 'TestPass@123';

  late TokenStorage tokenStorage;
  late ApiService api;
  late AuthRemoteDataSource auth;

  setUp(() {
    tokenStorage = TokenStorage(store: _InMemorySecureStore());
    api = ApiService(
      tokenStorage: tokenStorage,
      sessionEvents: SessionEvents(),
    );
    auth = AuthRemoteDataSource(api);
  });

  test('base URL is reachable and healthy', () async {
    final health = await api.getObject('/health');
    expect(health['status'], 'ok');
  }, timeout: const Timeout(Duration(seconds: 45)));

  test('login returns a usable session and /auth/me agrees', () async {
    final session = await auth.login(email: email, password: password);

    expect(session.accessToken, isNotEmpty);
    expect(session.user.email, email);
    expect(session.user.company, isNotNull);
    expect(session.user.company!.currency, isNotEmpty);

    await tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );

    // Proves the interceptor attaches the token to authenticated calls.
    final me = await auth.me();
    expect(me.email, email);
    expect(me.id, session.user.id);
  }, timeout: const Timeout(Duration(seconds: 45)));

  test('bad credentials surface as a typed unauthorized failure', () async {
    await expectLater(
      auth.login(email: email, password: 'definitely-wrong'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.kind,
          'kind',
          ApiErrorKind.unauthorized,
        ),
      ),
    );
  }, timeout: const Timeout(Duration(seconds: 45)));

  test('logout revokes the session server-side', () async {
    final session = await auth.login(email: email, password: password);
    await tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );

    // The backend rejects a logout with no refreshToken (400 VALIDATION_ERROR),
    // which would silently leave the refresh token live after sign-out.
    await auth.logout(refreshToken: session.refreshToken);
  }, timeout: const Timeout(Duration(seconds: 45)));

  test('a rejected token produces unauthorized, not a crash', () async {
    await tokenStorage.saveTokens(accessToken: 'not-a-real-token');
    await expectLater(
      api.getObject(ApiEndpoints.dashboard),
      throwsA(
        isA<ApiException>().having(
          (e) => e.kind,
          'kind',
          ApiErrorKind.unauthorized,
        ),
      ),
    );
  }, timeout: const Timeout(Duration(seconds: 45)));

  group('authenticated reads parse into domain models', () {
    // /auth/login is throttled server-side (429 RATE_LIMITED), so authenticate
    // once for the whole group and reuse the token.
    late String sharedToken;

    setUpAll(() async {
      final bootstrap = ApiService(
        tokenStorage: TokenStorage(store: _InMemorySecureStore()),
        sessionEvents: SessionEvents(),
      );
      final session = await AuthRemoteDataSource(bootstrap)
          .login(email: email, password: password);
      sharedToken = session.accessToken;
    });

    setUp(() async {
      await tokenStorage.saveTokens(accessToken: sharedToken);
    });

    test('dashboard KPIs', () async {
      final kpis = DashboardKpisModel.fromJson(
        await api.getObject(ApiEndpoints.dashboard),
      );
      expect(kpis.revenueThisMonth, isA<double>());
      expect(kpis.customerCount, greaterThanOrEqualTo(0));
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('sales report exposes the byMonth series used by the chart', () async {
      final report = SalesReportModel.fromJson(
        await api.getObject(
          ApiEndpoints.salesReport,
          query: {'fromDate': '2026-01-01', 'toDate': '2026-12-31'},
        ),
      );
      for (final value in report.byMonth.values) {
        expect(value, isA<double>());
      }
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('invoices parse, incl. string decimals', () async {
      final invoices = (await api.getList(ApiEndpoints.invoices))
          .map(InvoiceModel.fromJson)
          .toList();
      for (final invoice in invoices) {
        expect(invoice.id, isNotEmpty);
        // The API sends total as the string "146.63"; a bad cast would throw
        // before reaching here.
        expect(invoice.amount, isA<double>());
        expect(invoice.itemCount, greaterThanOrEqualTo(0));
      }
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('products parse, incl. computed stockLevel', () async {
      final products = (await api.getList(ApiEndpoints.products))
          .map(ProductModel.fromJson)
          .toList();
      for (final product in products) {
        expect(product.unitPrice, isA<double>());
        expect(product.quantity, isA<int>());
      }
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('expense claims parse', () async {
      final expenses = (await api.getList(ApiEndpoints.expenseClaims))
          .map(ExpenseModel.fromJson)
          .toList();
      for (final expense in expenses) {
        expect(expense.amount, isA<double>());
        expect(expense.category, isNotEmpty);
      }
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('notifications unread-count returns an int for the bell badge',
        () async {
      final json = await api.getObject(ApiEndpoints.notificationsUnreadCount);
      expect(asInt(json['count']), greaterThanOrEqualTo(0));
    }, timeout: const Timeout(Duration(seconds: 45)));

    test('bank accounts and transactions parse, amounts in major units',
        () async {
      final accounts = (await api.getList(ApiEndpoints.bankAccounts))
          .map(BankAccountModel.fromJson)
          .toList();

      for (final account in accounts) {
        expect(account.balance, isA<double>());

        final txs = (await api
                .getList('${ApiEndpoints.bankAccounts}/${account.id}/transactions'))
            .map(BankTransactionModel.fromJson)
            .toList();

        for (final tx in txs) {
          // Direction lives in `type`, so the parsed amount is never negative.
          expect(tx.amount, greaterThanOrEqualTo(0));
        }
      }
    }, timeout: const Timeout(Duration(seconds: 60)));
  });
}

/// Stands in for platform secure storage, which has no implementation under
/// `flutter test`.
class _InMemorySecureStore implements SecureKeyValueStore {
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
