import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice_detail.dart';

abstract class SalesRepository {
  Future<List<Invoice>> getInvoices();

  /// Full invoice by numeric backend id ([Invoice.rawId]).
  Future<InvoiceDetail> getInvoice(int id);
}
