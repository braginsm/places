import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

/// мок места положения
const double currentLat = /*56.84987946580704;*/ 55.749054;
const double currentLon = /*53.247889685270756;*/ 37.623162;

/// временное хранение списков
List<Place> favoriteList = [];
List<Place> visitList = [];

class PlaceInteractor {
  List<Place?> _sortByDistance(List<Place?> list) {
    list.sort((a, b) => a!
        .getDistans(currentLat, currentLon)
        .compareTo(b!.getDistans(currentLat, currentLon)));
    return list;
  }

  ///Получение списка интересных мест
  Future<List<Place?>> getPlaces({int radius = 0, String category = '', int offset = 0}) async {
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

  ///Получить список избранных мест, отсортированных по удаленности
  List<Place?> getFavoritesPlaces() => _sortByDistance(favoriteList);

  ///Добавить место в список избранных
  void addToFavorites(Place place) =>
      favoriteList.contains(place) ? null : favoriteList.add(place);

  /// добавляет/удаляет место из избранного
  void toggleFavorites(Place place) => favoriteList.contains(place)
      ? removeFromFavorites(place)
      : addToFavorites(place);

  ///Удалить место из списка избранных
  void removeFromFavorites(Place place) => favoriteList.remove(place);

  ///Перемещает place за after
  void moveFavorites(Place after, Place place) {
    favoriteList.remove(place);
    favoriteList.insert(favoriteList.indexOf(after) + 1, place);
  }

  ///Перемещает place за after
  void moveVisit(Place after, Place place) {
    visitList.remove(place);
    visitList.insert(visitList.indexOf(after) + 1, place);
  }

  ///Получить посещенные места
  List<Place> getVisitPlaces() => visitList;

  ///Добавить место в посещенные
  void addToVisitingPlaces(Place place) =>
      visitList.contains(place) ? null : visitList.add(place);

  ///Добавить новое место
  Future<Place> addNewPlace(Place place) {
    return PlaceRepository().save(place);
  }
}
/// тест токен
