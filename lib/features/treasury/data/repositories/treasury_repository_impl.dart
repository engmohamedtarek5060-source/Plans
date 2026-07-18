import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/treasury/data/models/bank_account_model.dart';
import 'package:saudiaaaa/features/treasury/domain/entities/bank_account.dart';
import 'package:saudiaaaa/features/treasury/domain/repositories/treasury_repository.dart';

class TreasuryRepositoryImpl implements TreasuryRepository {
  const TreasuryRepositoryImpl(this._api);

  final ApiService _api;

  /// Transactions are per-account, so a company with many accounts would mean
  /// many calls. Cap the fan-out; the screen only shows a short feed.
  static const _maxAccountsToScan = 5;
  static const _feedLimit = 8;

  @override
  Future<List<BankAccount>> getAccounts() async {
    final rows = await _api.getList(ApiEndpoints.bankAccounts);
    return rows.map(BankAccountModel.fromJson).toList();
  }

  @override
  Future<List<BankTransaction>> getRecentTransactions(
    List<BankAccount> accounts,
  ) async {
    if (accounts.isEmpty) return const [];

    final scanned = accounts.take(_maxAccountsToScan);

    final perAccount = await Future.wait(
      scanned.map((account) async {
        try {
          final rows = await _api.getList(
            '${ApiEndpoints.bankAccounts}/${account.id}/transactions',
          );
          return rows.map(BankTransactionModel.fromJson).toList();
        } on ApiException {
          // One unreadable account must not empty the whole feed.
          return const <BankTransaction>[];
        }
      }),
    );

    final merged = perAccount.expand((e) => e).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return merged.take(_feedLimit).toList();
  }
}
