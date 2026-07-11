import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/models/product_model.dart';

void main() {
  group('OrderModel Tests', () {
    late ClientModel mockClient;
    late ProductModel mockProduct1;
    late ProductModel mockProduct2;

    setUp(() {
      mockClient = ClientModel(
        name: 'Jane Doe',
        email: 'jane@example.com',
        phone: '123456',
      );

      mockProduct1 = ProductModel(
        name: 'Mouse',
        price: 50.0,
        imageUrl: 'https://example.com/mouse.jpg',
      );

      mockProduct2 = ProductModel(
        name: 'Keyboard',
        price: 150.0,
        imageUrl: 'https://example.com/keyboard.jpg',
      );
    });

    test('OrderItem should calculate total correctly', () {
      final item = OrderItem(
        product: mockProduct1,
        quantity: 3,
      );

      expect(item.total, 150.0); // 50.0 * 3
    });

    test('OrderModel should calculate totalAmount correctly', () {
      final order = OrderModel(
        client: mockClient,
        items: [
          OrderItem(product: mockProduct1, quantity: 2), // 100.0
          OrderItem(product: mockProduct2, quantity: 1), // 150.0
        ],
      );

      expect(order.totalAmount, 250.0);
    });

    test('Should create an OrderModel with default id and date', () {
      final order = OrderModel(
        client: mockClient,
        items: [],
      );

      expect(order.id, isNotEmpty);
      expect(order.date, isNotNull);
    });

    test('copyWith should return a new instance with updated values', () {
      final order = OrderModel(
        client: mockClient,
        items: [],
      );

      final newDate = DateTime(2023, 1, 1);
      final newClient = mockClient.copyWith(name: 'Updated Jane');

      final updatedOrder = order.copyWith(
        client: newClient,
        date: newDate,
      );

      expect(updatedOrder.id, order.id);
      expect(updatedOrder.client.name, 'Updated Jane');
      expect(updatedOrder.date, newDate);
    });
  });
}
