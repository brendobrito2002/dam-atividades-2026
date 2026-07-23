import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendas_app/src/data/datasources/local/category/category_sqlite_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_sqlite_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_sqlite_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_sqlite_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/settings/settings_viewmodel.dart';

List<SingleChildWidget> get appProviders {
  // Inicialização de DataSources (singletons SQLite)
  final clientDatasource = ClientSqliteLocalDatasource.db;
  final productDatasource = ProductSqliteLocalDatasource.db;
  final orderDatasource = OrderSqliteLocalDatasource.db;
  final categoryDatasource = CategorySqliteLocalDatasource.db;

  // Inicialização de Repositories
  final clientRepository = ClientRepositoryImpl(clientDatasource);
  final productRepository = ProductRepositoryImpl(productDatasource);
  final orderRepository = OrderRepositoryImpl(orderDatasource);
  final categoryRepository = CategoryRepositoryImpl(categoryDatasource);

  return [
    ChangeNotifierProvider(
      create: (_) => ClientViewModel(clientRepository)..loadClients(),
    ),
    ChangeNotifierProvider(
      create: (_) => CategoryViewModel(categoryRepository)..loadCategories(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProductViewModel(productRepository)..loadProducts(),
    ),
    ChangeNotifierProvider(
      create: (_) => OrderViewModel(orderRepository)..loadOrders(),
    ),
    ChangeNotifierProvider(
      create: (_) => CartViewModel(orderRepository),
    ),
    ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
    ),
  ];
}