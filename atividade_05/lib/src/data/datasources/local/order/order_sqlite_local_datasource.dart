import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_sqlite_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_sqlite_local_datasource.dart';
import 'package:vendas_app/src/models/client_model.dart';
import 'package:vendas_app/src/models/order_model.dart';
import 'package:vendas_app/src/models/product_model.dart';

class OrderSqliteLocalDatasource implements OrderLocalDatasource {
  /// Construtor privado
  OrderSqliteLocalDatasource._();

  /// Instância única
  static final OrderSqliteLocalDatasource db = OrderSqliteLocalDatasource._();

  /// Instância única do banco
  Database? _db;

  /// Método para obter singleton
  Future<Database> get database async {
    if (_db == null) {
      _db = await _init();
    }
    return _db!;
  }

  Future<Database> _init() async {
    String path = join(await getDatabasesPath(), 'orders.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database inDb, int inVersion) async {
        await inDb.execute(
          'CREATE TABLE IF NOT EXISTS orders ('
          'id TEXT PRIMARY KEY,'
          'clientId TEXT,'
          'date TEXT'
          ')',
        );
        await inDb.execute(
          'CREATE TABLE IF NOT EXISTS order_items ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'orderId TEXT,'
          'productId TEXT,'
          'quantity INTEGER'
          ')',
        );
      },
    );

    return database;
  }

  Map<String, dynamic> _orderToMap(OrderModel inOrder) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = inOrder.id;
    map['clientId'] = inOrder.client.id;
    map['date'] = inOrder.date.toIso8601String();
    return map;
  }

  /// Reconstrói o OrderModel completo, buscando o cliente e os produtos
  /// nos seus respectivos datasources (cada entidade vive no seu próprio
  /// arquivo de banco).
  Future<OrderModel> _orderFromMap(
    Map inMap,
    List<ClientModel> allClients,
    List<ProductModel> allProducts,
    Database db,
  ) async {
    final client = allClients.firstWhere((c) => c.id == inMap['clientId']);

    final itemMaps = await db.query(
      'order_items',
      where: 'orderId = ?',
      whereArgs: [inMap['id']],
    );

    final items = itemMaps.map((itemMap) {
      final product =
          allProducts.firstWhere((p) => p.id == itemMap['productId']);
      return OrderItem(
        product: product,
        quantity: itemMap['quantity'] as int,
      );
    }).toList();

    return OrderModel(
      id: inMap['id'],
      client: client,
      items: items,
      date: DateTime.parse(inMap['date']),
    );
  }

  @override
  Future<List<OrderModel>> getAll() async {
    Database db = await database;

    // Busca os dados relacionados uma única vez, evitando repetir a
    // consulta a cada pedido.
    final allClients = await ClientSqliteLocalDatasource.db.getAll();
    final allProducts = await ProductSqliteLocalDatasource.db.getAll();

    var recs = await db.query('orders');

    var list = <OrderModel>[];
    for (final rec in recs) {
      list.add(await _orderFromMap(rec, allClients, allProducts, db));
    }

    return list;
  }

  @override
  Future<void> add(OrderModel order) async {
    Database db = await database;

    await db.insert('orders', _orderToMap(order));

    for (final item in order.items) {
      await db.insert('order_items', {
        'orderId': order.id,
        'productId': item.product.id,
        'quantity': item.quantity,
      });
    }
  }

  @override
  Future<void> update(OrderModel order) async {
    Database db = await database;

    await db.update(
      'orders',
      _orderToMap(order),
      where: 'id = ?',
      whereArgs: [order.id],
    );

    // Remove os itens antigos e insere os novos, forma mais simples
    // de sincronizar a lista de itens do pedido.
    await db.delete(
      'order_items',
      where: 'orderId = ?',
      whereArgs: [order.id],
    );

    for (final item in order.items) {
      await db.insert('order_items', {
        'orderId': order.id,
        'productId': item.product.id,
        'quantity': item.quantity,
      });
    }
  }

  @override
  Future<void> delete(String id) async {
    Database db = await database;

    await db.delete(
      'order_items',
      where: 'orderId = ?',
      whereArgs: [id],
    );

    await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}