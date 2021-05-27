import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/model/PlacesFilterRequestDto.dart';
import 'package:places/data/repository/Repository.dart';
import 'package:places/data/res/endPoints.dart';

class PlaceDtoRepository extends Repository {
  Future<List<PlaceDto>> filtered(PlacesFilterRequestDto filter) async {    
    try {
      Response res =
          await dio.post(EndPoint.filteredPlaces, data: jsonEncode(filter));
      List<dynamic> data = res.data;
      return data.isEmpty ? <PlaceDto>[] : data.map((element) => PlaceDto.fromJson(element)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
