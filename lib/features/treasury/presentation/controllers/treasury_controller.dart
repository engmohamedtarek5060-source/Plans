import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/treasury/data/repositories/treasury_repository_impl.dart';
import 'package:saudiaaaa/features/treasury/domain/entities/bank_account.dart';
import 'package:saudiaaaa/features/treasury/domain/repositories/treasury_repository.dart';

final treasuryRepositoryProvider = Provider<TreasuryRepository>(
  (ref) => TreasuryRepositoryImpl(ref.watch(apiServiceProvider)),
);

class TreasuryState {
  const TreasuryState({
    required this.accounts,
    required this.transactions,
  });

  final List<BankAccount> accounts;
  final List<BankTransaction> transactions;

  /// Combined balance across every account.
  double get totalBalance =>
      accounts.fold<double>(0, (sum, a) => sum + a.balance);

  bool get isEmpty => accounts.isEmpty && transactions.isEmpty;
}

final treasuryControllerProvider =
    AsyncNotifierProvider<TreasuryController, TreasuryState>(
  TreasuryController.new,
);

class TreasuryController extends AsyncNotifier<TreasuryState> {
  Future<TreasuryState> _load() async {
    final repo = ref.read(treasuryRepositoryProvider);
    // Transactions are keyed by account id, so accounts must resolve first.
    final accounts = await repo.getAccounts();
    final transactions = await repo.getRecentTransactions(accounts);
    return TreasuryState(accounts: accounts, transactions: transactions);
  }

  @override
  Future<TreasuryState> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }
}
