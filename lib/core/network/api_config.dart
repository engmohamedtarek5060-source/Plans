/// Network configuration for the Plans ERP backend.
class ApiConfig {
  const ApiConfig._();

  /// Overridable at build time:
  ///   flutter run --dart-define=API_BASE_URL=https://other.host/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://admin.plansksa.cloud/api',
  );

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}

/// Every endpoint the app talks to, in one place.
class ApiEndpoints {
  const ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';

  // Dashboard / reports
  static const String dashboard = '/reports/dashboard';
  static const String salesReport = '/reports/sales';

  // Sales
  static const String invoices = '/sales/invoices';
  static const String customers = '/sales/customers';

  // Inventory
  static const String products = '/inventory/products';
  static const String stockAlerts = '/inventory/stock-alerts';

  // Treasury
  static const String bankAccounts = '/banking/accounts';

  // Expenses
  static const String expenseClaims = '/hr/expense-claims';
}
