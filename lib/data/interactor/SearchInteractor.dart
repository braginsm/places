import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/model/PlacesFilterRequestDto.dart';
import 'package:places/data/repository/PlaceDtoRepository.dart';

List<PlaceDto> searchHistory = [];

class SerachInteractor {
  Future<List<PlaceDto>> searchPlacesByName(String name,
      {double radius = 10000000.0}) async {
    var filter = PlacesFilterRequestDto(
      lat: currentLat,
      lon: currentLon,
      radius: radius,
      typeFilter: ['name'],
      nameFilter: name,
    );
    return await PlaceDtoRepository().filtered(filter);
  }
}
