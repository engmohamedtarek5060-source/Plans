import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/error_message.dart';
import 'package:saudiaaaa/core/utils/formatters.dart';
import 'package:saudiaaaa/core/utils/number_input.dart';
import 'package:saudiaaaa/core/utils/validators.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/empty_state.dart';
import 'package:saudiaaaa/core/widgets/error_state.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/core/widgets/screen_header.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense_category.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';
import 'package:saudiaaaa/features/expenses/presentation/controllers/add_expense_controller.dart';

/// Files a new expense claim against `POST /hr/expense-claims`.
///
/// The backend models an expense as a *claim* owned by an employee and made up
/// of at least one line. This form collects a single line, which is what "add an
/// expense" means to the user, and wraps it in the claim the API requires.
class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  /// The date field is read-only and driven by the picker, but it still needs a
  /// stable controller — building one inline in `build` would allocate a fresh
  /// controller on every frame and never dispose it.
  final _dateController = TextEditingController();

  int? _employeeId;
  ExpenseCategory? _category;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      // Expenses are historical: allow a generous back-window but no future
      // claims, which the finance team would only have to reject.
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit(bool isArabic) async {
    if (!_formKey.currentState!.validate()) return;

    final employeeId = _employeeId;
    final category = _category;
    // Both are guarded by validators; this satisfies null-safety without
    // asserting on user-driven state.
    if (employeeId == null || category == null) return;

    final amount = parseAmountInput(_amountController.text);
    if (amount == null) return;

    final description = _descriptionController.text.trim();

    final expense = NewExpense(
      employeeId: employeeId,
      date: _date,
      description: description,
      lines: [
        NewExpenseLine(
          category: category,
          description: description,
          amount: amount,
          // A single-line claim shares the claim's date; the API requires a date
          // on the line regardless.
          date: _date,
        ),
      ],
    );

    // Captured before the await: after popping, this State's context is gone but
    // the messenger and navigator are still valid.
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final colors = context.appColors;

    final succeeded = await ref
        .read(addExpenseControllerProvider.notifier)
        .submit(expense);

    if (!mounted) return;

    if (succeeded) {
      navigator.pop();
      messenger.showSnackBar(
        _snackBar(AppStrings.expenseCreated(isArabic), colors.success),
      );
      return;
    }

    final error = ref.read(addExpenseControllerProvider).error;
    messenger.showSnackBar(
      _snackBar(
        error == null
            ? AppStrings.errorTitle(isArabic)
            : describeError(error, isArabic),
        colors.error,
      ),
    );
  }

  SnackBar _snackBar(String message, Color background) => SnackBar(
    content: Text(message),
    backgroundColor: background,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final locale = isArabic ? 'ar' : 'en';
    final colors = context.appColors;
    final asyncEmployees = ref.watch(employeeOptionsProvider);
    final isSubmitting = ref.watch(addExpenseControllerProvider).isLoading;

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        // Blocked mid-flight: leaving now would orphan a request
                        // whose result the user still needs.
                        onPressed: isSubmitting
                            ? null
                            : () => Navigator.of(context).pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: colors.inputFill,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ScreenHeader(
                      title: AppStrings.addExpenseTitle(isArabic),
                      subtitle: AppStrings.addExpenseSubtitle(isArabic),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    asyncEmployees.when(
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (error, _) => ErrorState(
                        message: describeError(error, isArabic),
                        retryLabel: AppStrings.retry(isArabic),
                        onRetry: () => ref.invalidate(employeeOptionsProvider),
                      ),
                      // A claim cannot exist without an employee to own it, so
                      // say so plainly instead of showing a form that can only
                      // fail validation.
                      data: (employees) => employees.isEmpty
                          ? EmptyState(
                              title: AppStrings.noEmployeesTitle(isArabic),
                              subtitle: AppStrings.noEmployeesSubtitle(
                                isArabic,
                              ),
                              icon: Icons.badge_outlined,
                            )
                          : _buildForm(
                              context,
                              isArabic: isArabic,
                              locale: locale,
                              employees: employees,
                              isSubmitting: isSubmitting,
                            ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required bool isArabic,
    required String locale,
    required List<EmployeeOption> employees,
    required bool isSubmitting,
  }) {
    return GlassSurface(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<int>(
              initialValue: _employeeId,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppStrings.employee(isArabic),
                prefixIcon: const Icon(Icons.badge_outlined, size: 20),
              ),
              items: [
                for (final employee in employees)
                  DropdownMenuItem<int>(
                    value: employee.id,
                    child: Text(
                      employee.label(isArabic),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: isSubmitting
                  ? null
                  : (value) => setState(() => _employeeId = value),
              validator: (value) =>
                  value == null ? AppStrings.employeeRequired(isArabic) : null,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<ExpenseCategory>(
              initialValue: _category,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppStrings.expenseCategory(isArabic),
                prefixIcon: const Icon(Icons.category_outlined, size: 20),
              ),
              items: [
                for (final category in ExpenseCategory.values)
                  DropdownMenuItem<ExpenseCategory>(
                    value: category,
                    child: Text(
                      category.label(isArabic),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: isSubmitting
                  ? null
                  : (value) => setState(() => _category = value),
              validator: (value) => value == null
                  ? AppStrings.expenseCategoryRequired(isArabic)
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: AppStrings.expenseDate(isArabic),
              // A read-only field driven by the picker: free-typed dates in two
              // calendars and two numeral systems are not worth parsing.
              readOnly: true,
              controller: TextEditingController(
                text: Formatters.date(_date, locale: locale),
              ),
              prefixIcon: Icons.event_outlined,
              onTap: isSubmitting ? null : _pickDate,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              controller: _descriptionController,
              label: AppStrings.description(isArabic),
              prefixIcon: Icons.notes_outlined,
              validator: (value) => Validators.requiredText(
                value,
                message: AppStrings.descriptionRequired(isArabic),
                minLength: NewExpense.minDescriptionLength,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              controller: _amountController,
              label: AppStrings.amount(isArabic),
              prefixIcon: Icons.payments_outlined,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) => Validators.amount(
                value,
                message: AppStrings.amountRequired(isArabic),
                min: NewExpense.minLineAmount,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomPrimaryButton(
              label: AppStrings.saveExpense(isArabic),
              onPressed: isSubmitting ? null : () => _submit(isArabic),
              isLoading: isSubmitting,
              icon: Icons.check_rounded,
              useGradient: true,
            ),
          ],
        ),
      ),
    );
  }
}
