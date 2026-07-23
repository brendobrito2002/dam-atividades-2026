import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_local_datasource.dart';
import 'package:vendas_app/src/models/client_model.dart';

class ClientSqliteLocalDatasource implements ClientLocalDatasource {
  /// Construtor privado
  ClientSqliteLocalDatasource._();

  /// Instância única
  static final ClientSqliteLocalDatasource db =
      ClientSqliteLocalDatasource._();

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
    String path = join(await getDatabasesPath(), 'clients.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database inDb, int inVersion) async {
        await inDb.execute(
          'CREATE TABLE IF NOT EXISTS clients ('
          'id TEXT PRIMARY KEY,'
          'name TEXT,'
          'email TEXT,'
          'phone TEXT'
          ')',
        );
      },
    );

    return database;
  }

  ClientModel _clientFromMap(Map inMap) {
    return ClientModel(
      id: inMap['id'],
      name: inMap['name'],
      email: inMap['email'],
      phone: inMap['phone'],
    );
  }

  Map<String, dynamic> _clientToMap(ClientModel inClient) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = inClient.id;
    map['name'] = inClient.name;
    map['email'] = inClient.email;
    map['phone'] = inClient.phone;
    return map;
  }

  @override
  Future<List<ClientModel>> getAll() async {
    Database db = await database;
    var recs = await db.query('clients');
    var list = recs.isNotEmpty
        ? recs.map((m) => _clientFromMap(m)).toList()
        : <ClientModel>[];
    return list;
  }

  @override
  Future<void> add(ClientModel client) async {
    Database db = await database;
    await db.insert('clients', _clientToMap(client));
  }

  @override
  Future<void> update(ClientModel client) async {
    Database db = await database;
    await db.update(
      'clients',
      _clientToMap(client),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    Database db = await database;
    await db.delete(
      'clients',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}