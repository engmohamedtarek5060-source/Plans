import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/repositories/sales_repository.dart';

class GetInvoices {
  const GetInvoices(this._repository);
  final SalesRepository _repository;
  Future<List<Invoice>> call() => _repository.getInvoices();
}
