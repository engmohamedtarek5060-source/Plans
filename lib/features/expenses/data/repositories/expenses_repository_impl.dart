import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/expenses/data/models/expense_model.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
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
}
