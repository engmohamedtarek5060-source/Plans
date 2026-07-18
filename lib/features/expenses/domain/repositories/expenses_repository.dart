import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';

abstract class ExpensesRepository {
  Future<List<Expense>> getExpenses();
}
