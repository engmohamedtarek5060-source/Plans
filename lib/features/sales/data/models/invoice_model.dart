import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';

/// GET /sales/invoices -> bare JSON array.
///
/// Verified shape (money fields are Prisma Decimals, i.e. **strings**):
/// ```
/// {id:int, invoiceNumber:String, date:ISO, dueDate:ISO, customerId:int,
///  subtotal:"127.5", vatAmount:"19.13", total:"146.63", paidAmount:"0",
///  status:"DRAFT", customer:{id,name,vatNumber}, lines:[...],
///  _count:{payments:int}, zatcaXml:String(large)}
/// ```
/// `zatcaXml` is deliberately not read — it is a multi-KB blob per row and the
/// list UI has no use for it.
class InvoiceModel {
  const InvoiceModel._();

  static Invoice fromJson(Map<String, dynamic> json) {
    final customer = asMap(json['customer']);
    final lines = asMapList(json['lines']);

    final total = asDouble(json['total']);
    final paid = asDouble(json['paidAmount']);
    final dueDate = asDateOrNull(json['dueDate']);
    final rawStatus = asString(json['status']).toUpperCase();

    final customerName = asString(
      customer['name'],
      fallback: 'Customer #${asInt(json['customerId'])}',
    );

    return Invoice(
      rawId: asInt(json['id']),
      // Show the human invoice number; fall back to the row id.
      id: asString(
        json['invoiceNumber'],
        fallback: '#${asInt(json['id'])}',
      ),
      customer: customerName,
      // The backend keeps no Arabic customer name on the invoice relation.
      customerAr: customerName,
      date: asDate(json['date']),
      amount: total,
      status: statusFor(rawStatus: rawStatus, total: total, paid: paid, dueDate: dueDate),
      itemCount: lines.length,
    );
  }

  /// Maps backend invoice state onto the three buckets the UI filters by.
  ///
  /// The backend's own statuses (DRAFT/POSTED/PAID/…) don't line up with
  /// paid/pending/overdue, so settlement and the due date decide:
  ///  - fully settled            -> paid
  ///  - past due and unsettled   -> overdue
  ///  - otherwise                -> pending
  ///
  /// Shared with the detail view so a row and its detail never disagree.
  static InvoiceStatus statusFor({
    required String rawStatus,
    required double total,
    required double paid,
    required DateTime? dueDate,
  }) {
    if (rawStatus == 'PAID' || (total > 0 && paid >= total)) {
      return InvoiceStatus.paid;
    }
    if (rawStatus == 'CANCELLED' || rawStatus == 'VOID') {
      // No dedicated bucket exists; treat as non-actionable.
      return InvoiceStatus.pending;
    }
    if (dueDate != null && DateTime.now().isAfter(dueDate)) {
      return InvoiceStatus.overdue;
    }
    return InvoiceStatus.pending;
  }
}
