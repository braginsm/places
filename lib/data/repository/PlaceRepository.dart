import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceRepository extends Repository {

  /// Проверка статуса запроса
  static dynamic _checkStatus(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
        break;
      case 400:
      case 409:
        throw Exception(response.data['error']);
        break;
      case 404:
        throw Exception("No object found.");
      default:
        throw Exception("error: status code ${response.statusCode}");
    }
  }

  /// Получение места по его id
  Future<Place> getById(String id) async {
    try {
      Response res = await dio.get("/place/$id");
      var data = _checkStatus(res);
      return Place.fromJson(data);
    } catch (e) {
      throw e;
    }
  }

  /// Удаление места по его id
  Future<bool> deleteById(String id) async {
    try {
      Response res = await dio.delete("/place/$id");
      _checkStatus(res);
      return true;
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
      var data = _checkStatus(res);
      return data.map((element) => Place.fromJson(element)).toList();
    } catch (e) {
      throw e;
    }
  }

  /// Сохранение нового места
  Future<Place> save(Place place) async {
    try {
      Response res = await dio.post('/place', data: place);
      var data = _checkStatus(res);
      return Place.fromJson(data);
    } catch (e) {
      throw e;
    }
  }

  /// Обновление данных места
  Future<Place> update(Place place) async {
    try {
      Response res = await dio.put('/place/${place.id}', data: place);
      var data = _checkStatus(res);
      return Place.fromJson(data);
    } catch (e) {
      throw e;
    }
  }
}
