import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceRepository extends Repository {
  /// Получение места по его id
  Future<Place> getById(int id) async {
    try {
      Response res = await dio.get("/place/$id");
      return Place.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }

  /// Удаление места по его id
  Future<bool> deleteById(int id) async {
    try {
      await dio.delete("/place/$id");
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
    Map<String, dynamic> queryParameters = {};
    if (count != null) queryParameters['count'] = count;
    if (offset != null) queryParameters['offset'] = offset;
    if (pageBy != null) queryParameters['pageBy'] = pageBy;
    if (pageAfter != null) queryParameters['pageAfter'] = pageAfter;
    if (pagePrior != null) queryParameters['pagePrior'] = pagePrior;
    if (sortBy != null) queryParameters['sortBy'] = sortBy;
    try {
      Response res = await dio.get("/place", queryParameters: queryParameters);
      return (res.data as List<dynamic>)
        .map((e) => Place.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }

  /// Сохранение нового места
  Future<Place> save(Place place) async {
    try {
      Response res = await dio.post('/place', data: place);
      return Place.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }

  /// Обновление данных места
  Future<Place> update(Place place) async {
    try {
      Response res = await dio.put('/place/${place.id}', data: place);
      return Place.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }
}
