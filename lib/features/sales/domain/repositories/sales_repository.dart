import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';

abstract class SalesRepository {
  Future<List<Invoice>> getInvoices();
}
