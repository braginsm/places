import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

import 'place_favorit_interactor.dart';

/// мок места положения
const double currentLat = /*56.84987946580704;*/ 55.749054;
const double currentLon = /*53.247889685270756;*/ 37.623162;

class PlaceInteractor {
  List<Place?> _sortByDistance(List<Place?> list) {
    list.sort((a, b) => a!
        .getDistans(currentLat, currentLon)
        .compareTo(b!.getDistans(currentLat, currentLon)));
    return list;
  }

  ///Получение списка интересных мест
  Future<List<Place?>> getPlaces(
      {int radius = 0, String category = '', int offset = 0}) async {
    List<Place> places = await PlaceRepository().getByParameters(
      count: 5,
      offset: 0,
    );
    places.forEach((element) {
      if ((radius > 0 && radius < element.getDistans(currentLat, currentLon)) ||
          (category != '' && element.placeType.toString() != category)) {
        places.remove(element);
      }
    });
    return _sortByDistance(places);
  }

  ///Возвращает детализацию места
  Future<Place> getPlaceDetails(int id) async {
    return await PlaceRepository().getById(id);
  }

  ///Добавить новое место
  Future<Place> addNewPlace(Place place) {
    return PlaceRepository().save(place);
  }

  Future<bool> inFavorit(Place place) async {
    try {
      final list = await PlaceFavoritInteractor().getAll();
      return list.any((element) => element.id == place.id);
    } catch (_) {
      return false;
    }
  }
}
