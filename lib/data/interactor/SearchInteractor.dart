import 'package:flutter/material.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/model/PlacesFilterRequestDto.dart';
import 'package:places/data/repository/PlaceDtoRepository.dart';

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
    return _radius.start <= place.distance && _radius.end >= place.distance;
  }

  TextEditingController searchBarController = TextEditingController();

  set controller(TextEditingController val) => searchBarController = val;

  List<PlaceDto> _searchResult = searchHistory;

  bool showPreloader = false;

  void search(String value) async {
    showPreloader = true;
    if (value.length > 0) {
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

  RangeValues _radius = RangeValues(100, 10000);

  RangeValues get radius => _radius;

  void radiusSet(RangeValues radius) {
    _radius = radius;
  }

  /// хранение значений фильтров
  List<bool> _filterValues = List.generate(PlaceType.other.index, (index) => false);

  bool filterValue(String name) => _filterValues[_titles.indexOf(name)];

  /// подписи фильтров
  final List<String> _titles = Place.ruPlaceTypeNames;

  List<String> get titles => _titles;

  void changeFilter(String name) {
    final index = _titles.indexOf(name);
    _filterValues[index] = !_filterValues[index];
  }

  void cleanFilter() {
    _filterValues = List.generate(6, (index) => false);
  }
}
