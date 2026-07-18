import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/inventory/domain/entities/product.dart';

/// GET /inventory/products -> bare JSON array.
///
/// Verified shape:
/// ```
/// {id:int, sku:String, name:String, nameAr:String, category:String,
///  costPrice:"5.5", sellingPrice:"12.75", reorderPoint:"20",
///  safetyStock:"0", unitOfMeasure:String, isActive:bool,
///  stockLevel:num,  // computed by the backend, real number
///  _count:{stockMovements:int}}
/// ```
class ProductModel {
  const ProductModel._();

  static Product fromJson(Map<String, dynamic> json) {
    final name = asString(json['name']);

    return Product(
      id: asString(json['id']),
      name: name,
      // nameAr is genuinely present on products; fall back to the English name
      // so an Arabic UI never renders a blank row.
      nameAr: asString(json['nameAr'], fallback: name),
      sku: asString(json['sku']),
      // stockLevel is computed server-side and can be absent on some rows.
      quantity: asInt(json['stockLevel']),
      // reorderPoint is the "low stock" threshold the alerts endpoint uses.
      minQuantity: asInt(json['reorderPoint']),
      unitPrice: asDouble(json['sellingPrice']),
      category: asString(json['category']),
      categoryAr: asString(json['category']),
    );
  }
}
