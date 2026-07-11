import 'package:vendas_app/src/models/product_model.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_local_datasource.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasource _localDatasource;

  ProductRepositoryImpl(this._localDatasource);

  @override
  Future<List<ProductModel>> getAll() {
    return _localDatasource.getAll();
  }

  @override
  Future<void> add(ProductModel product) {
    return _localDatasource.add(product);
  }

  @override
  Future<void> update(ProductModel product) {
    return _localDatasource.update(product);
  }

  @override
  Future<void> delete(String id) {
    return _localDatasource.delete(id);
  }
}
