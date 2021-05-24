import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/model/PlacesFilterRequestDto.dart';
import 'package:places/data/repository/PlaceDtoRepository.dart';

List<PlaceDto> searchHistory = [];

class SerachInteractor {
  Future<List<PlaceDto>> searchPlacesByName(String name) async {
    return await PlaceDtoRepository().filtered(PlacesFilterRequestDto(
      lat: currentLat,
      lon: currentLon,
      radius: 0,
      typeFilter: ['name'],
      nameFilter: name,
    ));
  }
}
