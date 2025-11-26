import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool _isDark = false;
  static const _kThemeKey = 'is_dark_theme';

  ThemeController() {
    _loadFromPrefs();
  }

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    _saveToPrefs();
    notifyListeners();
  }

  void setDark(bool value) {
    _isDark = value;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_kThemeKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kThemeKey, _isDark);
  }
}
