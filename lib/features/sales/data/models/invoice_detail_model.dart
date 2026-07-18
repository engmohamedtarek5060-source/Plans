import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/sales/data/models/invoice_model.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice_detail.dart';

/// GET /sales/invoices/{id}
///
/// Same envelope as the list row plus a full `customer` object and `payments`.
/// Money fields are Prisma Decimal strings; line quantities/prices too.
class InvoiceDetailModel {
  const InvoiceDetailModel._();

  static InvoiceDetail fromJson(Map<String, dynamic> json) {
    final customer = asMap(json['customer']);
    final total = asDouble(json['total']);
    final paid = asDouble(json['paidAmount']);
    final dueDate = asDateOrNull(json['dueDate']);
    final rawStatus = asString(json['status']).toUpperCase();

    final customerName = asString(
      customer['name'],
      fallback: 'Customer #${asInt(json['customerId'])}',
    );

    return InvoiceDetail(
      number: asString(json['invoiceNumber'], fallback: '#${asInt(json['id'])}'),
      customerName: customerName,
      customerEmail: asStringOrNull(customer['email']),
      customerPhone: asStringOrNull(customer['phone']),
      date: asDate(json['date']),
      dueDate: dueDate,
      // Reuse the exact bucket logic the list uses, so a row and its detail
      // never disagree on status.
      status: InvoiceModel.statusFor(
        rawStatus: rawStatus,
        total: total,
        paid: paid,
        dueDate: dueDate,
      ),
      subtotal: asDouble(json['subtotal']),
      vatAmount: asDouble(json['vatAmount']),
      discount: asDouble(json['discount']),
      total: total,
      paidAmount: paid,
      notes: asStringOrNull(json['notes']),
      lines: asMapList(json['lines']).map(_line).toList(),
    );
  }

  static InvoiceLine _line(Map<String, dynamic> json) {
    final product = asMap(json['product']);
    // Prefer the line's own description; fall back to the product name.
    final description = asStringOrNull(json['description']) ??
        asStringOrNull(product['name']) ??
        'Item';

    return InvoiceLine(
      description: description,
      quantity: asDouble(json['quantity']),
      unitPrice: asDouble(json['unitPrice']),
      vatAmount: asDouble(json['vatAmount']),
      total: asDouble(json['total']),
    );
  }
}
