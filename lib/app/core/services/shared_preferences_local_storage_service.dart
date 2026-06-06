import 'dart:convert';

import 'package:qual_time/app/core/services/local_storage_service_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorageService {
  final SharedPreferences _preferences;

  LocalStorageService(this._preferences);

  @override
  Future<JsonMap?> get(String key) async {
    try {
      final rawValue = _preferences.getString(key);

      if (rawValue == null) return null;

      return _decodeMap(rawValue);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool> set(String key, JsonMap value) async {
    try {
      return _preferences.setString(key, jsonEncode(value));
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> put(String key, JsonMap Function(JsonMap old) construct) async {
    try {
      final rawValue = _preferences.getString(key);
      final oldValue =
          rawValue == null ? <String, dynamic>{} : _decodeMap(rawValue);
      final newValue = construct(oldValue);

      return _preferences.setString(key, jsonEncode(newValue));
    } catch (_) {
      return false;
    }
  }

  JsonMap _decodeMap(String value) {
    final decodedValue = jsonDecode(value);

    if (decodedValue is! Map<String, dynamic>) {
      throw FormatException('Stored value is not a valid JSON map: $value');
    }

    return decodedValue;
  }
}
