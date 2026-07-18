import 'package:flutter/widgets.dart';

class SettingsViewModel extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get darkMode{
    return _isDarkMode;
  }

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}