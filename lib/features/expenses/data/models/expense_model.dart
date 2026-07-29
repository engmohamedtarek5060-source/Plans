import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense_category.dart';

/// GET /hr/expense-claims -> bare JSON array.
///
/// Verified shape:
/// ```
/// {id:int, claimNumber:"EC-00001", employeeId:int, claimDate:ISO,
///  totalAmount:"370", status:"PENDING", notes:String,
///  employees:{name, employeeNumber},          // note: relation is plural
///  lines:[{expenseType:"TRAVEL", description, amount:"250", date:ISO}]}
/// ```
class ExpenseModel {
  const ExpenseModel._();

  /// Claim `status` -> Arabic label, reused as the "payment method" slot.
  static const _statusAr = <String, String>{
    'PENDING': 'قيد الانتظار',
    'APPROVED': 'معتمد',
    'REJECTED': 'مرفوض',
    'REIMBURSED': 'تم الصرف',
  };

  static String _titleCase(String code) {
    if (code.isEmpty) return code;
    return code[0].toUpperCase() + code.substring(1).toLowerCase();
  }

  static Expense fromJson(Map<String, dynamic> json) {
    final lines = asMapList(json['lines']);
    final employee = asMap(json['employees']);

    // A claim has many lines and the list UI shows one row per claim, so the
    // dominant line's category represents the claim.
    final category = lines.isEmpty
        ? 'OTHER'
        : asString(lines.first['expenseType'], fallback: 'OTHER').toUpperCase();

    final status = asString(json['status'], fallback: 'PENDING').toUpperCase();

    // Prefer the claim note; fall back to the first line, then the claim
    // number, so the row always has a meaningful title.
    final claimNumber = asString(json['claimNumber']);
    final title = asStringOrNull(json['notes']) ??
        (lines.isEmpty ? null : asStringOrNull(lines.first['description'])) ??
        claimNumber;

    final employeeName = asStringOrNull(employee['name']);

    // Labels come from the shared enum so the read path and the Add Expense
    // picker can never drift apart. An unrecognised code (a category added
    // server-side) falls through to the title-cased code rather than being
    // relabelled "Other".
    final knownCategory = ExpenseCategory.tryFromCode(category);

    return Expense(
      id: claimNumber.isEmpty ? '${asInt(json['id'])}' : claimNumber,
      title: employeeName == null ? title : '$title — $employeeName',
      titleAr: employeeName == null ? title : '$title — $employeeName',
      category: knownCategory?.labelEn ?? _titleCase(category),
      categoryAr: knownCategory?.labelAr ?? _titleCase(category),
      amount: asDouble(json['totalAmount']),
      date: asDate(json['claimDate']),
      // The claim has no payment method; its status is the useful signal here.
      paymentMethod: _titleCase(status),
      paymentMethodAr: _statusAr[status] ?? _titleCase(status),
    );
  }
}
