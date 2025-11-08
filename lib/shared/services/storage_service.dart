import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _userBox = 'user_data';
  static const String _settingsBox = 'settings';
  static const String _chatBox = 'chat_data';
  
  static late Box _userDataBox;
  static late Box _settingsDataBox;
  static late Box _chatDataBox;

  static Future<void> init() async {
    _userDataBox = await Hive.openBox(_userBox);
    _settingsDataBox = await Hive.openBox(_settingsBox);
    _chatDataBox = await Hive.openBox(_chatBox);
  }

  // User Data Methods
  static Future<void> saveUserData(String key, dynamic value) async {
    await _userDataBox.put(key, value);
  }

  static T? getUserData<T>(String key) {
    return _userDataBox.get(key) as T?;
  }

  static Future<void> clearUserData() async {
    await _userDataBox.clear();
  }

  // Settings Methods
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settingsDataBox.put(key, value);
  }

  static T? getSetting<T>(String key) {
    return _settingsDataBox.get(key) as T?;
  }

  static Future<void> clearSettings() async {
    await _settingsDataBox.clear();
  }

  // Chat Data Methods
  static Future<void> saveChatData(String key, dynamic value) async {
    await _chatDataBox.put(key, value);
  }

  static T? getChatData<T>(String key) {
    return _chatDataBox.get(key) as T?;
  }

  static Future<void> clearChatData() async {
    await _chatDataBox.clear();
  }

  // General Methods
  static Future<void> clearAllData() async {
    await _userDataBox.clear();
    await _settingsDataBox.clear();
    await _chatDataBox.clear();
  }
}