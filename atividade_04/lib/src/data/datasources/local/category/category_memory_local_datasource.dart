import 'package:vendas_app/src/models/category_model.dart';
import 'category_local_datasource.dart';

class CategoryMemoryLocalDatasource implements CategoryLocalDatasource {
  final List<CategoryModel> _items = [];

  CategoryMemoryLocalDatasource() {
    _items.addAll([
      CategoryModel(name: 'Informática'),
      CategoryModel(name: 'Móveis'),
      CategoryModel(name: 'Geral'),
    ]);
  }

  @override
  Future<List<CategoryModel>> getAll() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> add(CategoryModel category) async {
    _items.add(category);
  }

  @override
  Future<void> update(CategoryModel category) async {
    final index = _items.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _items[index] = category;
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((c) => c.id == id);
  }
}
