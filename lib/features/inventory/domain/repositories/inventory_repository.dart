import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';

abstract class InventoryRepository {
  Future<List<Product>> getProducts();
}

/// Roll-up shown above the product list.
///
/// Derived from the loaded products rather than fetched: no single backend
/// endpoint carries all three numbers, and /inventory/stock-alerts returns
/// only the low-stock rows.
class InventorySummary {
  const InventorySummary({
    required this.totalProducts,
    required this.lowStockCount,
    required this.totalValue,
  });

  factory InventorySummary.from(List<Product> products) => InventorySummary(
        totalProducts: products.length,
        lowStockCount:
            products.where((p) => p.status != StockStatus.inStock).length,
        totalValue: products.fold<double>(0, (sum, p) => sum + p.totalValue),
      );

  final int totalProducts;
  final int lowStockCount;
  final double totalValue;
}
