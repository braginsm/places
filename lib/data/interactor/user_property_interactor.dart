import 'package:places/data/model/place.dart';
import 'package:places/data/model/user_property.dart';
import 'package:places/data/repository/user_property_repository.dart';

class UserPropertyInteractor {
  /// Получение минимального радиуса поиска
  Future<double> getMinSearchRadius() async {
    final property =
        await UserPropertyRepository().getDouble("minSearchRadius");
    var value = property.value;
    return value < 0 ? 0 : value;
  }

  /// Сохранение минимального радиуса поиска
  Future<bool> setMinSearchRadius(double value) async {
    final property = UserProperty<double>('minSearchRadius', value);
    return UserPropertyRepository().setDouble(property);
  }

  /// Получение максимального радиуса поиска
  Future<double> getMaxSearchRadius() async {
    final property =
        await UserPropertyRepository().getDouble("maxSearchRadius");
    var value = property.value;
    return value <= 0 ? 10000 : value;
  }

  /// Сохранение максимального радиуса поиска
  Future<bool> setMaxSearchRadius(double value) async {
    final property = UserProperty<double>('maxSearchRadius', value);
    return UserPropertyRepository().setDouble(property);
  }

  /// Получение выбранных в фильтре категорий
  Future<List<bool>> getCategoryFIlters() async {
    List<bool> result = [];
    for (var i = 0; i < PlaceType.values.length; i++) {
      final property =
          await UserPropertyRepository().getBool("categoryFilter_$i");
      result.add(property.value);
    }
    return result;
  }

  /// Сохранение выбранной в фильтре категорий
  Future<bool> setCategoryFIlters(int index, bool value) async {
    final property = UserProperty<bool>('categoryFilter_$index', value);
    return UserPropertyRepository().setBool(property);
  }

  /// Сохранение выбранных в фильтре категорий
  Future<bool> cleanCategoryFIlters() async {
    bool result = false;
    for (var i = 0; i < PlaceType.values.length; i++) {
      final property = UserProperty<bool>('categoryFilter_$i', false);
      result &= await UserPropertyRepository().setBool(property);
    }
    return result;
  }

  /// Получение признака включения темной темы
  Future<bool> getDarkTheme() async {
    final property = await UserPropertyRepository().getBool("darkTheme");
    return property.value;
  }

  /// Сохранение признака включения темной темы
  Future<bool> setDarkTheme(bool value) async {
    final property = UserProperty<bool>('darkTheme', value);
    return UserPropertyRepository().setBool(property);
  }

  /// Получение признака НЕ первого входа
  Future<bool> getIsNotFirst() async {
    final property = await UserPropertyRepository().getBool("isNotFirst");
    return property.value;
  }

  /// Сохранение признака НЕ первого входа
  Future<bool> setIsNotFirst(bool value) async {
    final property = UserProperty<bool>('isNotFirst', value);
    return UserPropertyRepository().setBool(property);
  }
}
