import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/expenses/data/repositories/expenses_repository_impl.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/expense.dart';
import 'package:saudiaaaa/features/expenses/domain/repositories/expenses_repository.dart';
import 'package:saudiaaaa/features/expenses/domain/usecases/get_expenses.dart';

final expensesRepositoryProvider = Provider<ExpensesRepository>(
  (ref) => ExpensesRepositoryImpl(ref.watch(apiServiceProvider)),
);

final getExpensesProvider = Provider<GetExpenses>(
  (ref) => GetExpenses(ref.watch(expensesRepositoryProvider)),
);

class ExpensesState {
  const ExpensesState({
    required this.expenses,
    this.searchQuery = '',
  });

  final List<Expense> expenses;
  final String searchQuery;

  /// Total claimed, summed from the loaded claims.
  double get total => expenses.fold<double>(0, (sum, e) => sum + e.amount);

  List<Expense> get filteredExpenses {
    if (searchQuery.isEmpty) return expenses;
    final q = searchQuery.toLowerCase();
    return expenses
        .where(
          (e) =>
              e.title.toLowerCase().contains(q) ||
              e.titleAr.contains(searchQuery) ||
              e.category.toLowerCase().contains(q),
        )
        .toList();
  }

  ExpensesState copyWith({
    List<Expense>? expenses,
    String? searchQuery,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final expensesControllerProvider =
    AsyncNotifierProvider<ExpensesController, ExpensesState>(
  ExpensesController.new,
);

class ExpensesController extends AsyncNotifier<ExpensesState> {
  Future<ExpensesState> _load({String searchQuery = ''}) async {
    final expenses = await ref.read(getExpensesProvider)();
    return ExpensesState(expenses: expenses, searchQuery: searchQuery);
  }

  @override
  Future<ExpensesState> build() => _load();

  void setSearch(String query) {
    state = state.whenData((data) => data.copyWith(searchQuery: query));
  }

  Future<void> refresh() async {
    final previousQuery = state.valueOrNull?.searchQuery ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(searchQuery: previousQuery));
  }
}
