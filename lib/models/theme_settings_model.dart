import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingsModel extends ChangeNotifier {
  static const String _prefKey = 'frisby_theme';
  bool _isDark = true;

  ThemeSettingsModel() {
    _loadFromPrefs();
  }

  bool get isDark => _isDark;

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);
    if (saved != null) {
      _isDark = saved == 'dark';
      notifyListeners();
    }
  }

  void setTheme(bool dark) async {
    _isDark = dark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, dark ? 'dark' : 'light');
  }

  void toggleTheme() {
    setTheme(!_isDark);
  }
}
