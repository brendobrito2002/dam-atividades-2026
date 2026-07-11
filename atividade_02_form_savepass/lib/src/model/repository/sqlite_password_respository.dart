import 'package:save_pass/src/model/password_model.dart';
import 'package:save_pass/src/model/user_profile_model.dart'; // Importação do novo modelo
import 'package:save_pass/src/model/repository/interface/i_password_repository.dart';
import 'package:sqflite/sqflite.dart';

class SQlitePasswordRepository implements IPasswordRepository {
  final Database database;

  SQlitePasswordRepository(this.database);

  @override
  Future<PasswordModel> getPassword(String serviceName) async {
    final result = await database.query(
      'passwords',
      where: 'service_name = ?',
      whereArgs: [serviceName],
    );
    if (result.isNotEmpty) {
      return PasswordModel.fromJson(result.first);
    } else {
      throw Exception('No password found for service $serviceName');
    }
  }

  @override
  Future<void> savePassword(PasswordModel password) async {
    await database.insert(
      'passwords',
      password.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deletePassword(String serviceName) async {
    await database.delete(
      'passwords',
      where: 'service_name = ?',
      whereArgs: [serviceName],
    );
  }

  Future<void> updatePassword(PasswordModel password) async {
    await database.update(
      'passwords',
      password.toJson(),
      where: 'service_name = ?',
      whereArgs: [password.serviceName],
    );
  }

  @override
  Future<List<PasswordModel>> getAllPasswords() async {
    final result = await database.query('passwords');
    return result.map((json) => PasswordModel.fromJson(json)).toList();
  }

  Future<UserProfileModel?> getProfile() async {
    final result = await database.query(
      'profile',
      where: 'id = ?',
      whereArgs: [1],
    );
    if (result.isNotEmpty) {
      return UserProfileModel.fromJson(result.first);
    }
    return null;
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    await database.insert(
      'profile',
      profile.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Database> open() async {
    return openDatabase(
      'passwords.db',
      version: 2, // Incrementado para a versão 2 para incluir o perfil
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE passwords(service_name TEXT PRIMARY KEY, username TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE profile(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE profile(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
          );
        }
      },
    );
  }

  static Future<void> delete() async {
    await deleteDatabase('passwords.db');
  }

  static Future<void> close(Database database) async {
    await database.close();
  }
}
