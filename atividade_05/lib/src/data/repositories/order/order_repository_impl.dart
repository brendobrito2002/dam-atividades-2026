import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_local_datasource.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDatasource _localDatasource;

  OrderRepositoryImpl(this._localDatasource);

  @override
  Future<List<OrderModel>> getAll() {
    return _localDatasource.getAll();
  }

  @override
  Future<void> add(OrderModel order) {
    return _localDatasource.add(order);
  }

  @override
  Future<void> update(OrderModel order) {
    return _localDatasource.update(order);
  }

  @override
  Future<void> delete(String id) {
    return _localDatasource.delete(id);
  }
}
