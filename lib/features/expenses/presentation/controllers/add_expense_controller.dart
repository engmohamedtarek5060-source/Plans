import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';
import 'package:saudiaaaa/features/expenses/domain/usecases/create_expense.dart';
import 'package:saudiaaaa/features/expenses/domain/usecases/get_employees.dart';
import 'package:saudiaaaa/features/expenses/presentation/controllers/expenses_controller.dart';

final createExpenseProvider = Provider<CreateExpense>(
  (ref) => CreateExpense(ref.watch(expensesRepositoryProvider)),
);

final getEmployeesProvider = Provider<GetEmployees>(
  (ref) => GetEmployees(ref.watch(expensesRepositoryProvider)),
);

/// The employees the Add Expense form can file a claim against.
///
/// autoDispose so reopening the form after adding an employee in the backoffice
/// fetches a fresh list instead of serving a stale cache for the whole session.
final employeeOptionsProvider =
    FutureProvider.autoDispose<List<EmployeeOption>>(
  (ref) => ref.watch(getEmployeesProvider)(),
);

/// Drives one submission of the Add Expense form.
///
/// The state is the submission itself: `AsyncData` once a claim has been filed,
/// `AsyncError` carrying the typed [ApiException] when the backend refused it.
final addExpenseControllerProvider =
    AsyncNotifierProvider.autoDispose<AddExpenseController, void>(
  AddExpenseController.new,
);

class AddExpenseController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Nothing to load: the form owns its own fields and the employee list is a
    // separate provider. Starts idle.
  }

  /// Files [expense]; returns true when the backend accepted it.
  ///
  /// On success the expenses list is invalidated rather than patched locally —
  /// the server assigns the claim number, total and status, so re-reading is the
  /// only way to show the row as it actually exists.
  Future<bool> submit(NewExpense expense) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(
      () => ref.read(createExpenseProvider)(expense),
    );
    state = result;

    if (result.hasError) return false;

    await ref.read(expensesControllerProvider.notifier).refresh();
    return true;
  }
}
