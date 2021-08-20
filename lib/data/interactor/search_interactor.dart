import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_dto_repository.dart';

List<PlaceDto> searchHistory = [];

class SerachInteractor {
  Future<List<PlaceDto>> searchPlacesByName(String name,
      {double radius = 100000000.0}) async {
    var filter = PlacesFilterRequestDto(
      lat: currentLat,
      lon: currentLon,
      radius: radius,
      typeFilter: ['name'],
      nameFilter: name,
    );
    return await PlaceDtoRepository().filtered(filter);
  }

  ///Определяет, попадает ли достопримечательность в выбанный радиус
  bool inDistans(PlaceDto place) {
    return _radius.start <= place.distance! && _radius.end >= place.distance!;
  }

  TextEditingController searchBarController = TextEditingController();

  set controller(TextEditingController val) => searchBarController = val;

  List<PlaceDto> _searchResult = searchHistory;

  bool showPreloader = false;

  void search(String value) async {
    showPreloader = true;
    if (value.isNotEmpty) {
      _searchResult = await SerachInteractor().searchPlacesByName(value, radius: _radius.end);
    } else {
      _searchResult = [];
    }
    showPreloader = false;
  }

  void filterByRadius() {
    _searchResult = _searchResult.where(inDistans).toList();
  }

  List<PlaceDto> get searchResult => _searchResult;

  void clear() {
    _searchResult.clear();
  }

  RangeValues _radius = const RangeValues(100, 10000);

  RangeValues get radius => _radius;

  void radiusSet(RangeValues radius) {
    _radius = radius;
  }
}
