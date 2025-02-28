import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  Color _themeColor = Colors.blue;
  Color get themeColor => _themeColor;

  void changeTheme(Color newColor) {
    _themeColor = newColor;
    notifyListeners();
    _saveThemeToPrefs(newColor);
  }

  String _username = "User";
  String get username => _username;

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
    _saveUsernameToPrefs(newName);
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString("username") ?? "User";
    int colorValue = prefs.getInt("themeColor") ?? Colors.blue.value;
    _themeColor = Color(colorValue);
    notifyListeners();
  }

  Future<void> _saveUsernameToPrefs(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", name);
  }

  Future<void> _saveThemeToPrefs(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("themeColor", color.value);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
    _saveDarkModeToPrefs(value);
  }

  Future<void> _saveDarkModeToPrefs(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", value);
  }
}
