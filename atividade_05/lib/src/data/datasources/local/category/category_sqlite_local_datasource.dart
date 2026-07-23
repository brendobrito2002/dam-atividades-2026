import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendas_app/src/data/datasources/local/category/category_local_datasource.dart';
import 'package:vendas_app/src/models/category_model.dart';

class CategorySqliteLocalDatasource implements CategoryLocalDatasource {
  /// Construtor privado
  CategorySqliteLocalDatasource._();

  /// Instância única
  static final CategorySqliteLocalDatasource db =
      CategorySqliteLocalDatasource._();

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
    String path = join(await getDatabasesPath(), 'categories.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database inDb, int inVersion) async {
        await inDb.execute(
          'CREATE TABLE IF NOT EXISTS categories ('
          'id TEXT PRIMARY KEY,'
          'name TEXT'
          ')',
        );
      },
    );

    return database;
  }

  CategoryModel _categoryFromMap(Map inMap) {
    return CategoryModel(
      id: inMap['id'],
      name: inMap['name'],
    );
  }

  Map<String, dynamic> _categoryToMap(CategoryModel inCategory) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = inCategory.id;
    map['name'] = inCategory.name;
    return map;
  }

  @override
  Future<List<CategoryModel>> getAll() async {
    Database db = await database;
    var recs = await db.query('categories');
    var list = recs.isNotEmpty
        ? recs.map((m) => _categoryFromMap(m)).toList()
        : <CategoryModel>[];
    return list;
  }

  @override
  Future<void> add(CategoryModel category) async {
    Database db = await database;
    await db.insert('categories', _categoryToMap(category));
  }

  @override
  Future<void> update(CategoryModel category) async {
    Database db = await database;
    await db.update(
      'categories',
      _categoryToMap(category),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    Database db = await database;
    await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}