import 'package:flutter/widgets.dart';

class SettingsViewModel extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode{
    return _isDarkMode;
  }

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}