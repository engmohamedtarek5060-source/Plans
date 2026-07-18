import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/domain/repositories/expenses_repository.dart';

class GetExpenses {
  const GetExpenses(this._repository);
  final ExpensesRepository _repository;
  Future<List<Expense>> call() => _repository.getExpenses();
}
