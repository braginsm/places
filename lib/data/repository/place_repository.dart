import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/data/res/end_points.dart';

import 'file_repository.dart';
import 'network_exeption.dart';

class PlaceRepository extends Repository {
  /// Получение места по его id
  Future<Place> getById(int id) async {
    try {
      Response res = await dio.get("${EndPoint.place}/$id");
      return Place.fromJson(res.data);
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }

  /// Удаление места по его id
  Future<bool> deleteById(int id) async {
    try {
      await dio.delete("${EndPoint.place}/$id");
      return true;
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }

  /// получение списка мест по параметрам
  Future<List<Place>> getByParameters({
    int? count,
    int? offset,
    String? pageBy,
    String? pageAfter,
    String? pagePrior,
    List<String>? sortBy,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (count != null) queryParameters['count'] = count;
    if (offset != null) queryParameters['offset'] = offset;
    if (pageBy != null) queryParameters['pageBy'] = pageBy;
    if (pageAfter != null) queryParameters['pageAfter'] = pageAfter;
    if (pagePrior != null) queryParameters['pagePrior'] = pagePrior;
    if (sortBy != null) queryParameters['sortBy'] = sortBy;
    try {
      Response res = await dio.get(EndPoint.place, queryParameters: queryParameters);
      return (res.data as List<dynamic>).map((e) => Place.fromJson(e)).toList();
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }

  /// Сохранение нового места
  Future<Place> save(Place place) async {
    try {
      if (place.urls.isNotEmpty) {
        final _urls = await FileRepository().upload(place.urls);
        place = place.copyWith(urls: _urls);
      }
      Response res = await dio.post(EndPoint.place, data: jsonEncode(place));
      return Place.fromJson(res.data);
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }

  /// Обновление данных места
  Future<Place> update(Place place) async {
    try {
      Response res =
          await dio.put('${EndPoint.place}/${place.id}', data: jsonEncode(place));
      return Place.fromJson(res.data);
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }
}
