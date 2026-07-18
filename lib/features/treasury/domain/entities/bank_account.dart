/// A company bank account, as shown on the treasury screen.
class BankAccount {
  const BankAccount({
    required this.id,
    required this.accountName,
    required this.bankName,
    required this.accountNumber,
    required this.currency,
    required this.balance,
    required this.isDefault,
  });

  final int id;
  final String accountName;
  final String bankName;
  final String accountNumber;
  final String currency;

  /// Current balance in major units (e.g. SAR).
  final double balance;

  final bool isDefault;

  /// Last four digits, for display — the full number is never shown.
  String get maskedNumber {
    if (accountNumber.length <= 4) return accountNumber;
    return '•••• ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

/// A line on a bank statement.
class BankTransaction {
  const BankTransaction({
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.isReconciled,
  });

  final int id;
  final String description;
  final DateTime date;

  /// Always positive, in major units. Direction is [isCredit], because the
  /// backend keeps the sign in a separate `type` field rather than the value.
  final double amount;

  /// True for money in (CREDIT), false for money out (DEBIT).
  final bool isCredit;

  final bool isReconciled;
}
