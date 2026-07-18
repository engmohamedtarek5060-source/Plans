import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/treasury/domain/entities/bank_account.dart';

/// GET /banking/accounts -> bare JSON array.
///
/// ```
/// {id:int, accountName, bankName, accountNumber, iban, currency,
///  openingBalance:"0", currentBalance:"0", isActive:bool, isDefault:bool,
///  chartAccount:{name, code}}
/// ```
class BankAccountModel {
  const BankAccountModel._();

  static BankAccount fromJson(Map<String, dynamic> json) => BankAccount(
        id: asInt(json['id']),
        accountName: asString(json['accountName']),
        bankName: asString(json['bankName']),
        accountNumber: asString(json['accountNumber']),
        currency: asString(json['currency'], fallback: 'SAR'),
        // Decimal string in major units, like the rest of the ledger.
        balance: asDouble(json['currentBalance']),
        isDefault: asBool(json['isDefault']),
      );
}

/// GET /banking/accounts/{id}/transactions -> bare JSON array.
///
/// ```
/// {id:int, transactionDate:ISO, description, amount:"14663",
///  type:"CREDIT"|"DEBIT", status:"UNRECONCILED", currency}
/// ```
class BankTransactionModel {
  const BankTransactionModel._();

  /// This endpoint reports `amount` in **minor units** (halalas) — a 146.63 SAR
  /// import comes back as "14663" — while every other endpoint uses major
  /// units. Verified by round-tripping a CSV feed import.
  static const int _minorUnitsPerMajor = 100;

  static BankTransaction fromJson(Map<String, dynamic> json) {
    final type = asString(json['type']).toUpperCase();

    return BankTransaction(
      id: asInt(json['id']),
      description: asString(json['description']),
      date: asDate(json['transactionDate']),
      // Always positive: direction is carried by `type`, not by the sign.
      amount: asDouble(json['amount']).abs() / _minorUnitsPerMajor,
      isCredit: type == 'CREDIT',
      isReconciled: asString(json['status']).toUpperCase() == 'RECONCILED',
    );
  }
}
