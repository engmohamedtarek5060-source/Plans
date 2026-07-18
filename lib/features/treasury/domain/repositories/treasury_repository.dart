import 'package:saudiaaaa/features/treasury/domain/entities/bank_account.dart';

abstract class TreasuryRepository {
  Future<List<BankAccount>> getAccounts();

  /// Recent statement lines across [accounts], newest first.
  Future<List<BankTransaction>> getRecentTransactions(
    List<BankAccount> accounts,
  );
}
