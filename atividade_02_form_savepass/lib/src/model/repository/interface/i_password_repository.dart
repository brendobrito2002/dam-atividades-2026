import 'package:save_pass/src/model/password_model.dart';

abstract class IPasswordRepository {
  Future<PasswordModel> getPassword(String serviceName);
  Future<void> savePassword(PasswordModel password);
  Future<void> deletePassword(String serviceName);
  Future<List<PasswordModel>> getAllPasswords();
}
