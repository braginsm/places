import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/PlaceRepository.dart';

/// мок места положения
final double currentLat = 56.84987946580704;
final double currentLon = 53.247889685270756;

class PlaceInteractor {
  List<Place> _favorites = [];
  List<Place> _viziting = [];

  List<Place> _sortByDistance(List<Place> list) {
    list.sort((a, b) => a
        .getDistans(currentLat, currentLon)
        .compareTo(b.getDistans(currentLat, currentLon)));
    return list;
  }

  ///Получение списка интересных мест
  Future<List<Place>> getPlaces([int radius = 0, String category = '']) async {
    List<Place> places = await PlaceRepository().getByParameters(
      count: 100,
    );
    places.forEach((element) {
      if ((radius > 0 && radius < element.getDistans(currentLat, currentLon)) ||
          (category != '' && element.placeType.toString() != category))
        places.remove(element);
    });
    return _sortByDistance(places);
  }

  ///Возвращает детализацию места
  Future<Place> getPlaceDetails(int id) async {
    return await PlaceRepository().getById(id);
  }

  ///Получить список избранных мест, отсортированных по удаленности
  List<Place> getFavoritesPlaces() => _sortByDistance(_favorites);

  ///Добавить место в список избранных
  void addToFavorites(Place place) => _favorites.contains(place);

  ///Удалить место из списка избранных
  void removeFromFavorites(Place place) => _favorites.remove(place);

  ///Получить посещенные места
  List<Place> getVisitPlaces() => _viziting;

  ///Добавить место в посещенные
  void addToVisitingPlaces(Place place) => _viziting.contains(place);

  ///Добавить новое место
  Future<Place> addNewPlace(Place place) async {
    return await PlaceRepository().save(place);
  }
}
