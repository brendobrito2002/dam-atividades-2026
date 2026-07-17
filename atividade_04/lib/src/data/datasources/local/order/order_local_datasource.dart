import 'package:vendas_app/src/models/order_model.dart';

abstract class OrderLocalDatasource {
  Future<List<OrderModel>> getAll();
  Future<void> add(OrderModel order);
  Future<void> update(OrderModel order);
  Future<void> delete(String id);
}
