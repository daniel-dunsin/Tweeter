import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _getPrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs;
}

class LocalStorage {
  const LocalStorage();

  static Future<void> setString(
      {required dynamic key, required String value}) async {
    final prefs = await _getPrefs();

    prefs.setString(key, value);
  }

  static Future<void> setBool(
      {required dynamic key, required bool value}) async {
    final prefs = await _getPrefs();

    prefs.setBool(key, value);
  }

  static Future<void> setNumber(
      {required dynamic key, required double value}) async {
    final prefs = await _getPrefs();

    prefs.setDouble(key, value);
  }

  static Future<void> setList(
      {required dynamic key, required List<String> value}) async {
    final prefs = await _getPrefs();

    prefs.setStringList(key, value);
  }

  static Future<String?> getString({required dynamic key}) async {
    final prefs = await _getPrefs();

    return prefs.getString(key);
  }

  static Future<T?> getAny<T>({required dynamic key}) async {
    final prefs = await _getPrefs();

    return prefs.get(key) as T;
  }

  static Future<bool?> getBool({required dynamic key}) async {
    final prefs = await _getPrefs();

    return prefs.getBool(key);
  }

  static Future<double?> getNumber({required dynamic key}) async {
    final prefs = await _getPrefs();

    return prefs.getDouble(key);
  }

  static Future<List<String>?> getList({required dynamic key}) async {
    final prefs = await _getPrefs();

    return prefs.getStringList(key);
  }

  static Future<void> removeEntry({required dynamic key}) async {
    final prefs = await _getPrefs();

    prefs.remove(key);
  }
}
