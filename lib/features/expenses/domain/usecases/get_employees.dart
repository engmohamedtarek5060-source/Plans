import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';
import 'package:saudiaaaa/features/expenses/domain/repositories/expenses_repository.dart';

class GetEmployees {
  const GetEmployees(this._repository);
  final ExpensesRepository _repository;
  Future<List<EmployeeOption>> call() => _repository.getEmployees();
}
