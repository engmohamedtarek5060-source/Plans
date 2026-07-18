enum StockStatus { inStock, lowStock, outOfStock }

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.sku,
    required this.quantity,
    required this.minQuantity,
    required this.unitPrice,
    required this.category,
    required this.categoryAr,
  });

  final String id;
  final String name;
  final String nameAr;
  final String sku;
  final int quantity;
  final int minQuantity;
  final double unitPrice;
  final String category;
  final String categoryAr;

  StockStatus get status {
    if (quantity <= 0) return StockStatus.outOfStock;
    if (quantity <= minQuantity) return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  double get totalValue => quantity * unitPrice;
}
