import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/repositories/sales_repository.dart';
import 'package:saudiaaaa/features/sales/domain/usecases/get_invoices.dart';

final salesRepositoryProvider = Provider<SalesRepository>(
  (ref) => SalesRepositoryImpl(ref.watch(apiServiceProvider)),
);

final getInvoicesProvider = Provider<GetInvoices>(
  (ref) => GetInvoices(ref.watch(salesRepositoryProvider)),
);

enum InvoiceFilter { all, paid, pending, overdue }

class SalesState {
  const SalesState({
    required this.invoices,
    this.filter = InvoiceFilter.all,
    this.searchQuery = '',
  });

  final List<Invoice> invoices;
  final InvoiceFilter filter;
  final String searchQuery;

  List<Invoice> get filteredInvoices =>
      _applyFilter(invoices, filter, searchQuery);

  /// Per-status counts for the filter chips, derived from the loaded list: the
  /// backend has no count endpoint, and re-fetching to count would be a second
  /// round-trip over the same rows.
  Map<String, int> get stats => {
        'all': invoices.length,
        'paid': invoices.where((i) => i.status == InvoiceStatus.paid).length,
        'pending':
            invoices.where((i) => i.status == InvoiceStatus.pending).length,
        'overdue':
            invoices.where((i) => i.status == InvoiceStatus.overdue).length,
      };

  SalesState copyWith({
    List<Invoice>? invoices,
    InvoiceFilter? filter,
    String? searchQuery,
  }) {
    return SalesState(
      invoices: invoices ?? this.invoices,
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  static List<Invoice> _applyFilter(
    List<Invoice> invoices,
    InvoiceFilter filter,
    String query,
  ) {
    var result = invoices;

    result = switch (filter) {
      InvoiceFilter.all => result,
      InvoiceFilter.paid =>
        result.where((i) => i.status == InvoiceStatus.paid).toList(),
      InvoiceFilter.pending =>
        result.where((i) => i.status == InvoiceStatus.pending).toList(),
      InvoiceFilter.overdue =>
        result.where((i) => i.status == InvoiceStatus.overdue).toList(),
    };

    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      result = result
          .where(
            (i) =>
                i.id.toLowerCase().contains(q) ||
                i.customer.toLowerCase().contains(q) ||
                i.customerAr.contains(query),
          )
          .toList();
    }

    return result;
  }
}

final salesControllerProvider =
    AsyncNotifierProvider<SalesController, SalesState>(
  SalesController.new,
);

class SalesController extends AsyncNotifier<SalesState> {
  @override
  Future<SalesState> build() async {
    final invoices = await ref.read(getInvoicesProvider)();
    return SalesState(invoices: invoices);
  }

  void setFilter(InvoiceFilter filter) {
    state = state.whenData((data) => data.copyWith(filter: filter));
  }

  void setSearch(String query) {
    state = state.whenData((data) => data.copyWith(searchQuery: query));
  }

  Future<void> refresh() async {
    // Preserve the active filter/search across a refresh.
    final previous = state.valueOrNull;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final invoices = await ref.read(getInvoicesProvider)();
      return SalesState(
        invoices: invoices,
        filter: previous?.filter ?? InvoiceFilter.all,
        searchQuery: previous?.searchQuery ?? '',
      );
    });
  }
}
