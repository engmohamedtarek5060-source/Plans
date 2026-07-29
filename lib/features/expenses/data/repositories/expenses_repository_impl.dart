import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/expenses/data/models/employee_option_model.dart';
import 'package:saudiaaaa/features/expenses/data/models/expense_model.dart';
import 'package:saudiaaaa/features/expenses/data/models/new_expense_payload.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';
import 'package:saudiaaaa/features/expenses/domain/repositories/expenses_repository.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  const ExpensesRepositoryImpl(this._api);

  final ApiService _api;

  @override
  Future<List<Expense>> getExpenses() async {
    final rows = await _api.getList(ApiEndpoints.expenseClaims);
    return rows.map(ExpenseModel.fromJson).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<List<EmployeeOption>> getEmployees() async {
    final rows = await _api.getList(ApiEndpoints.employees);
    return rows
            .map(EmployeeOptionModel.fromJson)
            // id 0 means the row carried no usable id; it could never be posted.
            .where((employee) => employee.id > 0)
            .toList()
        ..sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
  }

  @override
  Future<void> createExpense(NewExpense expense) => _api.post(
        ApiEndpoints.expenseClaims,
        body: NewExpensePayload.toJson(expense),
      );
}
