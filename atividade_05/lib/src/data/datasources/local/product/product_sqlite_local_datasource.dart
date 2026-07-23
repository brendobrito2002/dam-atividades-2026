import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_local_datasource.dart';
import 'package:vendas_app/src/models/product_model.dart';

class ProductSqliteLocalDatasource implements ProductLocalDatasource {
  /// Construtor privado
  ProductSqliteLocalDatasource._();

  /// Instância única
  static final ProductSqliteLocalDatasource db =
      ProductSqliteLocalDatasource._();

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
    String path = join(await getDatabasesPath(), 'products.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database inDb, int inVersion) async {
        await inDb.execute(
          'CREATE TABLE IF NOT EXISTS products ('
          'id TEXT PRIMARY KEY,'
          'name TEXT,'
          'price REAL,'
          'imageUrl TEXT,'
          'category TEXT,'
          'isFavorite INTEGER'
          ')',
        );
      },
    );

    return database;
  }

  ProductModel _productFromMap(Map inMap) {
    return ProductModel(
      id: inMap['id'],
      name: inMap['name'],
      price: inMap['price'],
      imageUrl: inMap['imageUrl'],
      category: inMap['category'],
      isFavorite: inMap['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> _productToMap(ProductModel inProduct) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = inProduct.id;
    map['name'] = inProduct.name;
    map['price'] = inProduct.price;
    map['imageUrl'] = inProduct.imageUrl;
    map['category'] = inProduct.category;
    map['isFavorite'] = inProduct.isFavorite ? 1 : 0;
    return map;
  }

  @override
  Future<List<ProductModel>> getAll() async {
    Database db = await database;
    var recs = await db.query('products');
    var list = recs.isNotEmpty
        ? recs.map((m) => _productFromMap(m)).toList()
        : <ProductModel>[];
    return list;
  }

  @override
  Future<void> add(ProductModel product) async {
    Database db = await database;
    await db.insert('products', _productToMap(product));
  }

  @override
  Future<void> update(ProductModel product) async {
    Database db = await database;
    await db.update(
      'products',
      _productToMap(product),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    Database db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}