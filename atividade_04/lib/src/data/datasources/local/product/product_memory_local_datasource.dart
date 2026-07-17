import 'package:vendas_app/src/models/product_model.dart';
import 'product_local_datasource.dart';

class ProductMemoryLocalDatasource implements ProductLocalDatasource {
  final List<ProductModel> _items = [];

  ProductMemoryLocalDatasource() {
    _items.addAll([
      ProductModel(
        name: 'Notebook',
        price: 2500.0,
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=600&auto=format&fit=crop',
        category: 'Informática',
      ),
      ProductModel(
        name: 'Cadeira',
        price: 80.0,
        imageUrl: 'https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?q=80&w=600&auto=format&fit=crop',
        category: 'Móveis',
      ),
      ProductModel(
        name: 'Teclado Mecânico',
        price: 150.0,
        imageUrl: 'https://images.unsplash.com/photo-1595225476474-87563907a212?q=80&w=600&auto=format&fit=crop',
        category: 'Informática',
      ),
      ProductModel(
        name: 'Monitor 24" Full HD',
        price: 500.0,
        imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=600&auto=format&fit=crop',
        category: 'Informática',
      ),
      ProductModel(
        name: 'Mouse Sem Fio',
        price: 50.0,
        imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?q=80&w=600&auto=format&fit=crop',
        category: 'Informática',
      ),
    ]);
  }

  @override
  Future<List<ProductModel>> getAll() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> add(ProductModel product) async {
    _items.add(product);
  }

  @override
  Future<void> update(ProductModel product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _items[index] = product;
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((p) => p.id == id);
  }
}
