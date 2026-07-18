import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/sales/data/models/invoice_model.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/repositories/sales_repository.dart';

class SalesRepositoryImpl implements SalesRepository {
  const SalesRepositoryImpl(this._api);

  final ApiService _api;

  @override
  Future<List<Invoice>> getInvoices() async {
    final rows = await _api.getList(ApiEndpoints.invoices);
    return rows.map(InvoiceModel.fromJson).toList()
      // The backend returns insertion order; the UI wants newest first.
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}
