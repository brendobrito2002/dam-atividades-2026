import 'package:flutter_test/flutter_test.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_memory_local_datasource.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';

void main() {
  late OrderMemoryLocalDatasource datasource;

  setUp(() {
    datasource = OrderMemoryLocalDatasource();
  });

  group('OrderMemoryLocalDatasource Tests', () {
    test('Should initialize with an empty list', () async {
      final orders = await datasource.getAll();
      expect(orders.isEmpty, true);
    });

    test('Should add a new order', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      
      await datasource.add(newOrder);
      
      final orders = await datasource.getAll();
      expect(orders.length, 1);
      expect(orders.last.id, newOrder.id);
    });

    test('Should update an existing order', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      await datasource.add(newOrder);
      
      final updatedOrder = newOrder.copyWith(client: tClient.copyWith(name: 'Updated'));
      await datasource.update(updatedOrder);
      
      final currentOrders = await datasource.getAll();
      expect(currentOrders.first.client.name, 'Updated');
    });

    test('Should delete an order by id', () async {
      final tClient = ClientModel(name: 'Client', email: '', phone: '');
      final newOrder = OrderModel(client: tClient, items: []);
      await datasource.add(newOrder);
      
      await datasource.delete(newOrder.id);
      
      final currentOrders = await datasource.getAll();
      expect(currentOrders.isEmpty, true);
    });
  });
}
