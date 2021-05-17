import 'package:dio/dio.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceRepository extends Repository {
  Future<Place> getById(String id) async {
    try {
      Response res = await dio.get("/place/$id");
      if (res.statusCode == 200) return Place.fromJson(res.data);
      throw Exception("Место с id = $id не найдено");
    } catch (e) {
      throw e;
    }
  }

  Future<bool> deleteById(String id) async {
    try {
      Response res = await dio.delete("/place/$id");
      if (res.statusCode == 200) return true;
      throw Exception("Место с id = $id не найдено");
    } catch (e) {
      throw e;
    }
  }
}
