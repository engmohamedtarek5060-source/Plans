import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';
import 'package:saudiaaaa/features/inventory/domain/repositories/inventory_repository.dart';

class GetProducts {
  const GetProducts(this._repository);
  final InventoryRepository _repository;
  Future<List<Product>> call() => _repository.getProducts();
}
