import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _getPrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs;
}

class LocalStorage {
  const LocalStorage();

  static Future<void> setString(
      {required String key, required String value}) async {
    final prefs = await _getPrefs();

    prefs.setString(key, value);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    final prefs = await _getPrefs();

    prefs.setBool(key, value);
  }

  static Future<void> setNumber(
      {required String key, required double value}) async {
    final prefs = await _getPrefs();

    prefs.setDouble(key, value);
  }

  static Future<void> setList(
      {required String key, required List<String> value}) async {
    final prefs = await _getPrefs();

    prefs.setStringList(key, value);
  }

  static Future<String?> getString({required String key}) async {
    final prefs = await _getPrefs();

    return prefs.getString(key);
  }

  static Future<T?> getAny<T>({required String key}) async {
    final prefs = await _getPrefs();

    return prefs.getString(key) as T;
  }

  static Future<bool?> getBool({required String key}) async {
    final prefs = await _getPrefs();

    return prefs.getBool(key);
  }

  static Future<double?> getNumber({required String key}) async {
    final prefs = await _getPrefs();

    return prefs.getDouble(key);
  }

  static Future<List<String>?> getList({required String key}) async {
    final prefs = await _getPrefs();

    return prefs.getStringList(key);
  }

  static Future<void> removeEntry({required String key}) async {
    final prefs = await _getPrefs();

    prefs.remove(key);
  }
}
