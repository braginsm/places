import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

import 'geo_interactor.dart';
import 'place_favorit_interactor.dart';

class PlaceInteractor {
  Future<List<Place?>> _sortByDistance(List<Place?> list) async {
    final current = await GeoInteractor().currentPosition;
    list.sort((a, b) => a!
        .getDistans(current)
        .compareTo(b!.getDistans(current)));
    return list;
  }

  ///Получение списка интересных мест
  Future<List<Place?>> getPlaces(
      {int radius = 0, String category = '', int offset = 0}) async {
    List<Place> places = await PlaceRepository().getByParameters(
      count: 5,
      offset: 0,
    );
    final current = await GeoInteractor().currentPosition;
    places.forEach((element) {
      if ((radius > 0 && radius < element.getDistans(current)) ||
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

  Future<bool> inFavorit(PlaceFavoritInteractor interactor, Place place) async {
    try {
      final list = await interactor.getAll();
      return list.any((element) => element.id == place.id);
    } catch (_) {
      return false;
    }
  }
}
