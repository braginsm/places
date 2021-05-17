import 'package:dio/dio.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceRepository extends Repository {
  /// Получение места по его id
  Future<Place> getById(String id) async {
    try {
      Response res = await dio.get("/place/$id");
      if (res.statusCode == 200) return Place.fromJson(res.data);
      throw Exception("Место с id = $id не найдено");
    } catch (e) {
      throw e;
    }
  }

  /// Удаление места по его id
  Future<bool> deleteById(String id) async {
    try {
      Response res = await dio.delete("/place/$id");
      if (res.statusCode == 200) return true;
      throw Exception("Место с id = $id не найдено");
    } catch (e) {
      throw e;
    }
  }

  /// получение списка мест по параметрам
  Future<List<Place>> getByParameters({
    int count,
    int offset,
    String pageBy,
    String pageAfter,
    String pagePrior,
    List<String> sortBy,
  }) async {
    Map<String, dynamic> queryParameters;
    if (count != null) queryParameters['count'] = count;
    if (offset != null) queryParameters['offset'] = offset;
    if (pageBy != null) queryParameters['pageBy'] = pageBy;
    if (pageAfter != null) queryParameters['pageAfter'] = pageAfter;
    if (pagePrior != null) queryParameters['pagePrior'] = pagePrior;
    if (sortBy != null) queryParameters['sortBy'] = sortBy;
    try {
      Response res = await dio.get("/place", queryParameters: queryParameters);
      if (res.statusCode == 200)
        return res.data.map((element) => Place.fromJson(element)).toList();
      throw Exception(res.data['error']);
    } catch (e) {
      throw e;
    }
  }
}
