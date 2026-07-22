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
  static String emailRequired(bool isArabic) =>
      isArabic ? 'أدخل البريد الإلكتروني' : 'Enter your email';
  static String emailInvalid(bool isArabic) =>
      isArabic ? 'بريد إلكتروني غير صالح' : 'Enter a valid email address';
  static String passwordRequired(bool isArabic) =>
      isArabic ? 'أدخل كلمة المرور' : 'Enter your password';
  static String passwordTooShort(bool isArabic, int min) => isArabic
      ? 'كلمة المرور يجب أن تكون $min أحرف على الأقل'
      : 'Password must be at least $min characters';
  static String confirmPasswordRequired(bool isArabic) =>
      isArabic ? 'أعد إدخال كلمة المرور' : 'Re-enter your password';
  static String passwordsDoNotMatch(bool isArabic) =>
      isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';
  static String nameRequired(bool isArabic) =>
      isArabic ? 'أدخل اسمك' : 'Enter your name';
  static String companyNameRequired(bool isArabic) =>
      isArabic ? 'أدخل اسم الشركة' : 'Enter your company name';

  // Registration
  static String fullName(bool isArabic) =>
      isArabic ? 'الاسم الكامل' : 'Full name';
  static String companyName(bool isArabic) =>
      isArabic ? 'اسم الشركة' : 'Company name';
  static String confirmPassword(bool isArabic) =>
      isArabic ? 'تأكيد كلمة المرور' : 'Confirm password';
  static String registerTitle(bool isArabic) =>
      isArabic ? 'إنشاء حساب شركة' : 'Create a company account';
  static String registerSubtitle(bool isArabic) => isArabic
      ? 'أنشئ شركتك وابدأ الإدارة'
      : 'Set up your company and start managing it';
  static String createAccount(bool isArabic) =>
      isArabic ? 'إنشاء الحساب' : 'Create account';
  static String haveAccount(bool isArabic) =>
      isArabic ? 'لديك حساب بالفعل؟' : 'Already have an account?';
  static String emailAlreadyRegistered(bool isArabic) => isArabic
      ? 'هذا البريد الإلكتروني مسجل بالفعل. سجّل الدخول بدلاً من ذلك.'
      : 'That email is already registered. Sign in instead.';

  /// Shown to the client role, which has no self-registration path: client
  /// access is provisioned by the company the client buys from.
  static String clientAccountsProvisioned(bool isArabic) => isArabic
      ? 'يتم إنشاء حسابات العملاء من قبل الشركة. تواصل معها للحصول على صلاحية الدخول.'
      : 'Client accounts are created by your company. Contact them for access.';
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

  // Role selection
  static String chooseRoleTitle(bool isArabic) =>
      isArabic ? 'كيف ستستخدم التطبيق؟' : 'How will you use the app?';
  static String chooseRoleSubtitle(bool isArabic) => isArabic
      ? 'اختر نوع حسابك للمتابعة'
      : 'Choose your account type to continue';
  static String roleClient(bool isArabic) => isArabic ? 'عميل' : 'Client';
  static String roleClientDescription(bool isArabic) => isArabic
      ? 'تابع طلباتك وفواتيرك'
      : 'Follow your orders and invoices';
  static String roleCompany(bool isArabic) =>
      isArabic ? 'صاحب شركة' : 'Company Owner';
  static String roleCompanyDescription(bool isArabic) => isArabic
      ? 'إدارة المبيعات والمخزون والخزينة'
      : 'Manage sales, inventory and treasury';
  static String continueLabel(bool isArabic) => isArabic ? 'متابعة' : 'Continue';
  static String selected(bool isArabic) => isArabic ? 'محدد' : 'Selected';
  static String roleSaveFailed(bool isArabic) => isArabic
      ? 'تعذر حفظ اختيارك. حاول مرة أخرى'
      : "Couldn't save your choice. Please try again";
  static String switchRole(bool isArabic) =>
      isArabic ? 'تغيير نوع الحساب' : 'Switch account type';

  // Client
  static String clientHomeTitle(bool isArabic) =>
      isArabic ? 'بوابة العميل' : 'Client Portal';
  static String clientHomeEmptyTitle(bool isArabic) =>
      isArabic ? 'لا توجد طلبات بعد' : 'Nothing here yet';
  static String clientHomeEmptySubtitle(bool isArabic) => isArabic
      ? 'ستظهر طلباتك وفواتيرك هنا فور توفرها'
      : 'Your orders and invoices will appear here';
}
