import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeBoxName = 'theme_settings';
  static const String _themeModeKey = 'theme_mode';
  
  late Box _themeBox;
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  ThemeMode get materialThemeMode => _themeMode;
  
  bool get isDarkMode {
    return _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.window.platformBrightness == Brightness.dark);
  }
  
  bool get isLightMode {
    return _themeMode == ThemeMode.light ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.window.platformBrightness == Brightness.light);
  }
  
  bool get isSystemMode => _themeMode == ThemeMode.system;
  
  ThemeProvider() {
    _initializeTheme();
  }
  
  Future<void> _initializeTheme() async {
    try {
      _themeBox = await Hive.openBox(_themeBoxName);
      final savedTheme = _themeBox.get(_themeModeKey);
      
      if (savedTheme != null) {
        switch (savedTheme) {
          case 'light':
            _themeMode = ThemeMode.light;
            break;
          case 'dark':
            _themeMode = ThemeMode.dark;
            break;
          case 'system':
          default:
            _themeMode = ThemeMode.system;
            break;
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing theme: $e');
    }
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    notifyListeners();
    
    try {
      await _themeBox.put(_themeModeKey, _getThemeModeString(mode));
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }
  
  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await setThemeMode(newMode);
  }
  
  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
  
  Future<void> resetToSystem() async {
    await setThemeMode(ThemeMode.system);
  }
}