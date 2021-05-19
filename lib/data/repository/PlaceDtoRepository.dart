import 'package:dio/dio.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/model/PlacesFilterRequestDto.dart';
import 'package:places/data/repository/Repository.dart';

class PlaceDtoRepository extends Repository {
  Future<List<PlaceDto>> filtered(PlacesFilterRequestDto filter) async {
    try {
      Response res = await dio.post('/filtered_places', data: filter);
      return res.data.map((element) => PlaceDto.fromJson(element)).toList();
    } catch (e) {
      throw e;
    }
  }
}