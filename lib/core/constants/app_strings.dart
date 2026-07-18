/// Centralized bilingual strings for the ERP app.
abstract final class AppStrings {
  // App
  static String appName(bool isArabic) =>
      isArabic ? 'Plans ERP' : 'Plans ERP';

  // Navigation
  static String navDashboard(bool isArabic) =>
      isArabic ? 'الرئيسية' : 'Home';
  static String navSales(bool isArabic) => isArabic ? 'المبيعات' : 'Sales';
  static String navInventory(bool isArabic) =>
      isArabic ? 'المخزون' : 'Inventory';
  static String navTreasury(bool isArabic) =>
      isArabic ? 'الخزينة' : 'Treasury';
  static String navMore(bool isArabic) => isArabic ? 'المزيد' : 'More';

  // Dashboard
  static String greeting(bool isArabic) =>
      isArabic ? 'مرحباً' : 'Welcome back';
  static String dashboardTitle(bool isArabic) =>
      isArabic ? 'لوحة التحكم' : 'Dashboard';
  static String revenue(bool isArabic) => isArabic ? 'الإيرادات' : 'Revenue';
  static String expenses(bool isArabic) => isArabic ? 'المصروفات' : 'Expenses';
  static String balance(bool isArabic) => isArabic ? 'الرصيد' : 'Balance';
  static String quickActions(bool isArabic) =>
      isArabic ? 'إجراءات سريعة' : 'Quick Actions';
  static String recentActivity(bool isArabic) =>
      isArabic ? 'النشاط الأخير' : 'Recent Activity';
  static String overview(bool isArabic) =>
      isArabic ? 'نظرة عامة' : 'Overview';
  static String thisMonth(bool isArabic) =>
      isArabic ? 'هذا الشهر' : 'This month';

  // Sales
  static String salesTitle(bool isArabic) => isArabic ? 'المبيعات' : 'Sales';
  static String invoices(bool isArabic) => isArabic ? 'الفواتير' : 'Invoices';
  static String customers(bool isArabic) => isArabic ? 'العملاء' : 'Customers';
  static String newInvoice(bool isArabic) =>
      isArabic ? 'فاتورة جديدة' : 'New Invoice';
  static String paid(bool isArabic) => isArabic ? 'مدفوعة' : 'Paid';
  static String pending(bool isArabic) => isArabic ? 'معلقة' : 'Pending';
  static String overdue(bool isArabic) => isArabic ? 'متأخرة' : 'Overdue';

  // Inventory
  static String inventoryTitle(bool isArabic) =>
      isArabic ? 'المخزون' : 'Inventory';
  static String totalProducts(bool isArabic) =>
      isArabic ? 'إجمالي المنتجات' : 'Total Products';
  static String lowStock(bool isArabic) =>
      isArabic ? 'مخزون منخفض' : 'Low Stock';
  static String stockValue(bool isArabic) =>
      isArabic ? 'قيمة المخزون' : 'Stock Value';

  // Expenses
  static String expensesTitle(bool isArabic) =>
      isArabic ? 'المصروفات' : 'Expenses';
  static String addExpense(bool isArabic) =>
      isArabic ? 'إضافة مصروف' : 'Add Expense';
  static String totalExpenses(bool isArabic) =>
      isArabic ? 'إجمالي المصروفات' : 'Total Expenses';

  // Common
  static String search(bool isArabic) => isArabic ? 'بحث...' : 'Search...';
  static String loading(bool isArabic) => isArabic ? 'جاري التحميل' : 'Loading';
  static String retry(bool isArabic) => isArabic ? 'إعادة المحاولة' : 'Retry';
  static String emptyTitle(bool isArabic) =>
      isArabic ? 'لا توجد بيانات' : 'No data yet';
  static String emptySubtitle(bool isArabic) =>
      isArabic ? 'ستظهر البيانات هنا عند توفرها' : 'Data will appear here';
  static String errorTitle(bool isArabic) =>
      isArabic ? 'حدث خطأ' : 'Something went wrong';
  static String theme(bool isArabic) => isArabic ? 'المظهر' : 'Appearance';
  static String language(bool isArabic) => isArabic ? 'اللغة' : 'Language';
  static String darkMode(bool isArabic) => isArabic ? 'الوضع الداكن' : 'Dark mode';
  static String lightMode(bool isArabic) => isArabic ? 'الوضع الفاتح' : 'Light mode';
  static String systemMode(bool isArabic) =>
      isArabic ? 'تلقائي' : 'System';
  static String settings(bool isArabic) => isArabic ? 'الإعدادات' : 'Settings';
  static String viewAll(bool isArabic) => isArabic ? 'عرض الكل' : 'View all';

  // Auth
  static String loginTitle(bool isArabic) =>
      isArabic ? 'تسجيل الدخول' : 'Sign in';
  static String loginSubtitle(bool isArabic) => isArabic
      ? 'أدخل بياناتك للوصول إلى حسابك'
      : 'Enter your credentials to access your account';
  static String email(bool isArabic) =>
      isArabic ? 'البريد الإلكتروني' : 'Email';
  static String password(bool isArabic) =>
      isArabic ? 'كلمة المرور' : 'Password';
  static String forgotPassword(bool isArabic) =>
      isArabic ? 'نسيت كلمة المرور؟' : 'Forgot password?';
  static String signIn(bool isArabic) => isArabic ? 'دخول' : 'Sign in';
  static String noAccount(bool isArabic) =>
      isArabic ? 'ليس لديك حساب؟' : "Don't have an account?";
  static String signUp(bool isArabic) => isArabic ? 'إنشاء حساب' : 'Sign up';
  static String demoAccounts(bool isArabic) =>
      isArabic ? 'حسابات تجريبية' : 'Demo accounts';
  static String invalidCredentials(bool isArabic) => isArabic
      ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة'
      : 'Invalid email or password';
  static String sessionExpired(bool isArabic) => isArabic
      ? 'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى'
      : 'Your session expired. Please log in again';
  static String logout(bool isArabic) => isArabic ? 'تسجيل الخروج' : 'Log out';
  static String resetPassword(bool isArabic) =>
      isArabic ? 'إعادة تعيين كلمة المرور' : 'Reset password';
  static String resetPasswordHint(bool isArabic) => isArabic
      ? 'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة التعيين'
      : "Enter your email and we'll send you a reset link";
  static String sendResetLink(bool isArabic) =>
      isArabic ? 'إرسال الرابط' : 'Send reset link';
  static String backToLogin(bool isArabic) =>
      isArabic ? 'العودة لتسجيل الدخول' : 'Back to sign in';
}
