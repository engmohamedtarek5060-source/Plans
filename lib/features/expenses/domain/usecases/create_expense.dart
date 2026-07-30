import 'package:saudiaaaa/features/expenses/domain/entities/new_expense.dart';
import 'package:saudiaaaa/features/expenses/domain/repositories/expenses_repository.dart';

class CreateExpense {
  const CreateExpense(this._repository);
  final ExpensesRepository _repository;
  Future<void> call(NewExpense expense) => _repository.createExpense(expense);
}
