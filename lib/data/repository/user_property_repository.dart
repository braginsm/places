import 'package:places/data/model/user_property.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPropertyRepository {
  UserPropertyRepository();

  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<UserProperty> get(String key) async {
    var _value = (await prefs).get(key) ?? "";
    return UserProperty<dynamic>(key, _value);
  }

  Future<UserProperty<String>> getString(String key) async {
    var _value = (await prefs).getString(key) ?? "";
    return UserProperty<String>(key, _value);
  }

  Future<bool> setString(UserProperty<String> property) async {
    return (await prefs).setString(property.name, property.value);
  }

  Future<UserProperty<int>> getInt(String key) async {
    var _value = (await prefs).getInt(key) ?? 0;
    return UserProperty<int>(key, _value);
  }

  Future<bool> setInt(UserProperty<int> property) async {
    return (await prefs).setInt(property.name, property.value);
  }

  Future<UserProperty<double>> getDouble(String key) async {
    var _value = (await prefs).getDouble(key) ?? .0;
    return UserProperty<double>(key, _value);
  }

  Future<bool> setDouble(UserProperty<double> property) async {
    return (await prefs).setDouble(property.name, property.value);
  }

  Future<UserProperty<bool>> getBool(String key) async {
    var _value = (await prefs).getBool(key) ?? false;
    return UserProperty<bool>(key, _value);
  }

  Future<bool> setBool(UserProperty<bool> property) async {
    return (await prefs).setBool(property.name, property.value);
  }

  Future<UserProperty<List<String>>> getStringList(String key) async {
    var _value = (await prefs).getStringList(key) ?? [];
    return UserProperty<List<String>>(key, _value);
  }

  Future<bool> setStringList(UserProperty<List<String>> property) async {
    return (await prefs).setStringList(property.name, property.value);
  }
}
