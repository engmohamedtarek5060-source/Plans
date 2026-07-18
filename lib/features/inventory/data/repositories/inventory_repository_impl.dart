import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/inventory/data/models/product_model.dart';
import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';
import 'package:saudiaaaa/features/inventory/domain/repositories/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  const InventoryRepositoryImpl(this._api);

  final ApiService _api;

  @override
  Future<List<Product>> getProducts() async {
    final rows = await _api.getList(ApiEndpoints.products);
    return rows.map(ProductModel.fromJson).toList();
  }
}
