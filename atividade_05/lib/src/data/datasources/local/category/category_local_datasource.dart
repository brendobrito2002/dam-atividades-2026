import 'package:vendas_app/src/models/category_model.dart';

abstract class CategoryLocalDatasource {
  Future<List<CategoryModel>> getAll();
  Future<void> add(CategoryModel category);
  Future<void> update(CategoryModel category);
  Future<void> delete(String id);
}
