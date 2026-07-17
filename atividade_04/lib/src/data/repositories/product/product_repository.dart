import 'package:vendas_app/src/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAll();
  Future<void> add(ProductModel product);
  Future<void> update(ProductModel product);
  Future<void> delete(String id);
}
