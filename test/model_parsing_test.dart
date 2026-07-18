import 'package:flutter_test/flutter_test.dart';
import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';
import 'package:saudiaaaa/features/sales/data/models/invoice_model.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/treasury/data/models/bank_account_model.dart';
import 'package:saudiaaaa/features/inventory/data/models/product_model.dart';

/// Guards the two traps this backend sets:
///  1. money arrives as JSON *strings* (Prisma Decimal), not numbers;
///  2. /banking transactions report amounts in *minor units*, unlike the rest.
///
/// The payloads below are trimmed copies of real responses.
void main() {
  group('json coercion', () {
    test('accepts strings, nums, and null for the same field', () {
      expect(asDouble('146.63'), 146.63);
      expect(asDouble(146.63), 146.63);
      expect(asDouble(null), 0);
      expect(asDouble('not a number'), 0);
      expect(asInt('20'), 20);
      expect(asInt(20.9), 20);
      expect(asInt(null, fallback: -1), -1);
    });

    test('unwraps bare arrays and wrapped list responses alike', () {
      expect(asListResponse([
        {'id': 1}
      ]), hasLength(1));
      expect(
        asListResponse({
          'data': [
            {'id': 1},
            {'id': 2}
          ]
        }),
        hasLength(2),
      );
      // Garbage must yield an empty list, never throw.
      expect(asListResponse('nonsense'), isEmpty);
      expect(asListResponse(null), isEmpty);
    });
  });

  group('InvoiceModel', () {
    Map<String, dynamic> invoiceJson({
      String status = 'DRAFT',
      String total = '146.63',
      String paid = '0',
      String? dueDate = '2099-08-17T00:00:00.000Z',
    }) =>
        {
          'id': 5,
          'invoiceNumber': 'INV-202607-0001',
          'date': '2026-07-17T00:00:00.000Z',
          'dueDate': dueDate,
          'customerId': 4,
          'total': total,
          'paidAmount': paid,
          'status': status,
          'customer': {'id': 4, 'name': 'Acme Trading Co'},
          'lines': [
            {'id': 5, 'quantity': '10', 'unitPrice': '12.75'}
          ],
        };

    test('parses a string decimal total without throwing', () {
      final invoice = InvoiceModel.fromJson(invoiceJson());
      expect(invoice.amount, 146.63);
      expect(invoice.id, 'INV-202607-0001');
      expect(invoice.customer, 'Acme Trading Co');
      expect(invoice.itemCount, 1);
    });

    test('an unpaid invoice past its due date is overdue', () {
      final invoice = InvoiceModel.fromJson(
        invoiceJson(dueDate: '2020-01-01T00:00:00.000Z'),
      );
      expect(invoice.status, InvoiceStatus.overdue);
    });

    test('a fully settled invoice is paid even when status says otherwise', () {
      final invoice = InvoiceModel.fromJson(
        invoiceJson(status: 'POSTED', total: '146.63', paid: '146.63'),
      );
      expect(invoice.status, InvoiceStatus.paid);
    });

    test('an unpaid invoice not yet due is pending', () {
      expect(InvoiceModel.fromJson(invoiceJson()).status, InvoiceStatus.pending);
    });

    test('survives a row with nulls and missing relations', () {
      final invoice = InvoiceModel.fromJson({'id': 9});
      expect(invoice.amount, 0);
      expect(invoice.itemCount, 0);
      expect(invoice.customer, contains('#0'));
    });
  });

  group('ProductModel', () {
    test('maps stockLevel and reorderPoint into stock status', () {
      final product = ProductModel.fromJson({
        'id': 6,
        'sku': 'SKU-001',
        'name': 'Steel Bolt M8',
        'nameAr': 'مسمار',
        'category': 'Hardware',
        'sellingPrice': '12.75',
        'reorderPoint': '20',
        'stockLevel': 10,
      });

      expect(product.unitPrice, 12.75);
      expect(product.quantity, 10);
      expect(product.minQuantity, 20);
      // At or below the reorder point.
      expect(product.status, StockStatus.lowStock);
      expect(product.totalValue, 127.5);
    });

    test('falls back to the English name when nameAr is absent', () {
      final product = ProductModel.fromJson({'name': 'Widget'});
      expect(product.nameAr, 'Widget');
      expect(product.status, StockStatus.outOfStock);
    });
  });

  group('BankTransactionModel', () {
    test('converts minor units to major and takes direction from type', () {
      // "14663" halalas == 146.63 SAR.
      final credit = BankTransactionModel.fromJson({
        'id': 1,
        'transactionDate': '2026-07-10T00:00:00.000Z',
        'description': 'Client payment',
        'amount': '14663',
        'type': 'CREDIT',
        'status': 'UNRECONCILED',
      });
      expect(credit.amount, closeTo(146.63, 0.001));
      expect(credit.isCredit, isTrue);
      expect(credit.isReconciled, isFalse);

      // A 3,000 SAR debit: the sign lives in `type`, not the value.
      final debit = BankTransactionModel.fromJson({
        'id': 2,
        'transactionDate': '2026-07-12T00:00:00.000Z',
        'description': 'Office rent',
        'amount': '300000',
        'type': 'DEBIT',
        'status': 'RECONCILED',
      });
      expect(debit.amount, closeTo(3000, 0.001));
      expect(debit.isCredit, isFalse);
      expect(debit.isReconciled, isTrue);
    });
  });

  group('BankAccountModel', () {
    test('reads the balance as major units and masks the account number', () {
      final account = BankAccountModel.fromJson({
        'id': 3,
        'accountName': 'Main Operating Account',
        'bankName': 'Al Rajhi Bank',
        'accountNumber': '1234567890',
        'currency': 'SAR',
        'currentBalance': '1500.5',
        'isDefault': false,
      });
      expect(account.balance, 1500.5);
      expect(account.maskedNumber, endsWith('7890'));
      expect(account.maskedNumber, isNot(contains('123456')));
    });
  });
}
