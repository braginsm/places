import 'package:places/data/model/place_visit.dart';
import 'package:places/data/repository/place_visit_repository.dart';

class PlaceVisitInteractor {
  Future<List<PlaceVisit>> getAll() async {
    return await PlaceVisitRepository().getAll();
  }

  ///Добавить место в список посещенных
  void addPlace(PlaceVisit place) => PlaceVisitRepository().save(place);

  ///Удалить место из списка посещенных
  void removePlace(PlaceVisit place) =>
      PlaceVisitRepository().deleteById(place.id);
}
