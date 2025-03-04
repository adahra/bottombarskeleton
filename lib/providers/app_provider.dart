import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String _username = "User";
  Color _themeColor = Colors.blue;
  bool _isDarkMode = false;
  Locale _locale = Locale('en'); // Default bahasa Inggris

  String get username => _username;
  Color get themeColor => _themeColor;
  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
    _saveToPrefs("username", newName);
  }

  void changeTheme(Color newColor) {
    _themeColor = newColor;
    notifyListeners();
    _saveIntToPrefs("themeColor", newColor.value);
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
    _saveBoolToPrefs("isDarkMode", value);
  }

  void changeLanguage(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
    _saveToPrefs("languageCode", newLocale.languageCode);
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString("username") ?? "User";
    int colorValue = prefs.getInt("themeColor") ?? Colors.blue.value;
    _themeColor = Color(colorValue);
    _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    String? languageCode = prefs.getString("languageCode");
    _locale = Locale(languageCode ?? 'en');
    notifyListeners();
  }

  Future<void> _saveToPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> _saveIntToPrefs(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<void> _saveBoolToPrefs(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
