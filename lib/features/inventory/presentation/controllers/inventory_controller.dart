import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';
import 'package:saudiaaaa/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:saudiaaaa/features/inventory/domain/usecases/get_products.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InventoryRepositoryImpl(ref.watch(apiServiceProvider)),
);

final getProductsProvider = Provider<GetProducts>(
  (ref) => GetProducts(ref.watch(inventoryRepositoryProvider)),
);

class InventoryState {
  const InventoryState({
    required this.products,
    required this.summary,
    this.searchQuery = '',
  });

  final List<Product> products;
  final InventorySummary summary;
  final String searchQuery;

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    final q = searchQuery.toLowerCase();
    return products
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.nameAr.contains(searchQuery) ||
              p.sku.toLowerCase().contains(q),
        )
        .toList();
  }

  InventoryState copyWith({
    List<Product>? products,
    InventorySummary? summary,
    String? searchQuery,
  }) {
    return InventoryState(
      products: products ?? this.products,
      summary: summary ?? this.summary,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final inventoryControllerProvider =
    AsyncNotifierProvider<InventoryController, InventoryState>(
  InventoryController.new,
);

class InventoryController extends AsyncNotifier<InventoryState> {
  Future<InventoryState> _load({String searchQuery = ''}) async {
    final products = await ref.read(getProductsProvider)();
    return InventoryState(
      products: products,
      summary: InventorySummary.from(products),
      searchQuery: searchQuery,
    );
  }

  @override
  Future<InventoryState> build() => _load();

  void setSearch(String query) {
    state = state.whenData((data) => data.copyWith(searchQuery: query));
  }

  Future<void> refresh() async {
    final previousQuery = state.valueOrNull?.searchQuery ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(searchQuery: previousQuery));
  }
}
