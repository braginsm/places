import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/data/res/end_points.dart';

import 'network_exeption.dart';

class PlaceDtoRepository extends Repository {
  Future<List<PlaceDto>> filtered(PlacesFilterRequestDto filter) async {    
    try {
      Response res =
          await dio.post(EndPoint.filteredPlaces, data: jsonEncode(filter));
      List<dynamic> data = res.data;
      return data.isEmpty ? <PlaceDto>[] : data.map((element) => PlaceDto.fromJson(element)).toList();
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }
}
