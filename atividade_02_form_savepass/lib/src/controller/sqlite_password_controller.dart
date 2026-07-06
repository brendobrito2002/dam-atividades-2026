import 'package:flutter/foundation.dart';
import 'package:save_pass/src/model/password_model.dart';
import 'package:save_pass/src/model/repository/sqlite_password_respository.dart';

class SQlitePasswordController extends ChangeNotifier {
  late final SQlitePasswordRepository _passwordRepository;
  final List<PasswordModel> _passwords = [];
  List<PasswordModel> filteredPasswords = [];

  SQlitePasswordController() {
    SQlitePasswordRepository.open().then((database) {
      _passwordRepository = SQlitePasswordRepository(database);
      _passwordRepository.getAllPasswords().then((passwords) {
        _passwords.addAll(passwords);
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    SQlitePasswordRepository.close(_passwordRepository.database);
    _passwords.clear();
    super.dispose();
  }

  List<PasswordModel> get passwords => _passwords;

  Future<void> addPassword(PasswordModel password) async {
    await _passwordRepository.savePassword(password);
    _passwords.add(password);
    notifyListeners();
  }

  Future<void> deletePassword(PasswordModel password) async {
    await _passwordRepository.deletePassword(password.serviceName);
    _passwords.remove(password);
    notifyListeners();
  }

  Future<void> updatePassword(PasswordModel password) async {
    await _passwordRepository.updatePassword(password);
    _passwords.removeWhere((p) => p.serviceName == password.serviceName);
    _passwords.add(password);
    notifyListeners();
  }

  PasswordModel? getPassword(String serviceName) {
    final result = _passwords.firstWhere(
      (password) => password.serviceName == serviceName,
      orElse: () => PasswordModel(serviceName: '', username: '', password: ''),
    );
    if (result.serviceName.isNotEmpty) {
      return result;
    } else {
      return null;
    }
  }

  void search(String serviceName) {
    filteredPasswords = _passwords
        .where((password) => password.serviceName
            .toLowerCase()
            .contains(serviceName.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
