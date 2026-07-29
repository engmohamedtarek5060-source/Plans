import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';

abstract class ExpensesRepository {
  Future<List<Expense>> getExpenses();

  /// Employees a claim can be filed against, for the Add Expense picker.
  Future<List<EmployeeOption>> getEmployees();

  /// Files a new expense claim.
  ///
  /// Returns nothing on purpose: the create response shape has not been verified
  /// against the live backend, so callers re-read the list instead of trusting a
  /// body we would only be guessing at.
  Future<void> createExpense(NewExpense expense);
}
