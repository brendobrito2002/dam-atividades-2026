import 'package:vendas_app/src/data/datasources/local/category/category_local_datasource.dart';
import 'package:vendas_app/src/models/category_model.dart';
import 'category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDatasource _datasource;

  CategoryRepositoryImpl(this._datasource);

  @override
  Future<List<CategoryModel>> getAll() => _datasource.getAll();

  @override
  Future<void> add(CategoryModel category) => _datasource.add(category);

  @override
  Future<void> update(CategoryModel category) => _datasource.update(category);

  @override
  Future<void> delete(String id) => _datasource.delete(id);
}
