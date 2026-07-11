import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  group('ProductModel Tests', () {
    test('Should create a ProductModel with a generated id when not provided', () {
      final product = ProductModel(
        name: 'Notebook',
        price: 3500.0,
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(product.id, isNotEmpty);
      expect(product.name, 'Notebook');
      expect(product.price, 3500.0);
      expect(product.imageUrl, 'https://example.com/image.jpg');
    });

    test('copyWith should return a new instance with updated values', () {
      final product = ProductModel(
        name: 'Notebook',
        price: 3500.0,
        imageUrl: 'https://example.com/image.jpg',
      );

      final updatedProduct = product.copyWith(
        price: 3200.0,
      );

      expect(updatedProduct.id, product.id);
      expect(updatedProduct.name, 'Notebook');
      expect(updatedProduct.price, 3200.0);
      expect(updatedProduct.imageUrl, 'https://example.com/image.jpg');
    });
  });
}
