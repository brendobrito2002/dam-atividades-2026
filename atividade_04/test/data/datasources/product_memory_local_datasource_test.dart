import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  late ProductMemoryLocalDatasource datasource;

  setUp(() {
    datasource = ProductMemoryLocalDatasource();
  });

  group('ProductMemoryLocalDatasource Tests', () {
    test('Should initialize with five mocked products', () async {
      final products = await datasource.getAll();
      expect(products.length, 5);
      expect(products.first.name, 'Notebook Pro 15');
    });

    test('Should add a new product', () async {
      final newProduct = ProductModel(name: 'Teste', price: 10.0, imageUrl: '');
      await datasource.add(newProduct);
      
      final products = await datasource.getAll();
      expect(products.length, 6);
      expect(products.last.id, newProduct.id);
    });

    test('Should update an existing product', () async {
      final products = await datasource.getAll();
      final productToUpdate = products.first;
      
      final updatedProduct = productToUpdate.copyWith(name: 'Updated');
      await datasource.update(updatedProduct);
      
      final currentProducts = await datasource.getAll();
      expect(currentProducts.first.name, 'Updated');
    });

    test('Should delete a product by id', () async {
      final products = await datasource.getAll();
      final productToDelete = products.first;
      
      await datasource.delete(productToDelete.id);
      
      final currentProducts = await datasource.getAll();
      expect(currentProducts.length, 4);
      expect(currentProducts.where((p) => p.id == productToDelete.id).isEmpty, true);
    });
  });
}
