import 'package:flutter/foundation.dart';
import 'package:save_pass/src/model/password_model.dart';
import 'package:save_pass/src/model/repository/sqlite_password_respository.dart';
import 'package:save_pass/src/model/user_profile_model.dart';

class SQlitePasswordController extends ChangeNotifier {
  late final SQlitePasswordRepository _passwordRepository;
  late final Future<void> _initialization;
  final List<PasswordModel> _passwords = [];
  List<PasswordModel> filteredPasswords = [];
  UserProfile? profile;

  SQlitePasswordController() {
    _initialization = _initialize();
  }

  Future<void> _initialize() async {
    final database = await SQlitePasswordRepository.open();
    _passwordRepository = SQlitePasswordRepository(database);

    final passwords = await _passwordRepository.getAllPasswords();
    _passwords.addAll(passwords);
    notifyListeners();

    final savedProfile = await _passwordRepository.getProfile();
    profile = savedProfile;
    notifyListeners();
  }

  @override
  void dispose() {
    SQlitePasswordRepository.close(_passwordRepository.database);
    _passwords.clear();
    super.dispose();
  }

  List<PasswordModel> get passwords => _passwords;

  Future<void> addPassword(PasswordModel password) async {
    await _initialization;
    await _passwordRepository.savePassword(password);
    _passwords.add(password);
    notifyListeners();
  }

  Future<void> deletePassword(PasswordModel password) async {
    await _initialization;
    await _passwordRepository.deletePassword(password.serviceName);
    _passwords.remove(password);
    notifyListeners();
  }

  Future<void> updatePassword(PasswordModel password) async {
    await _initialization;
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

  Future<void> saveProfile(UserProfile newProfile) async {
    await _initialization;
    await _passwordRepository.saveProfile(newProfile);
    profile = newProfile;
    notifyListeners();
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