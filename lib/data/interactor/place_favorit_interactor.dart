import 'package:places/data/model/place_favorit.dart';
import 'package:places/data/repository/place_favorit_repository.dart';

class PlaceFavoritInteractor {
  Future<List<PlaceFavorit>> getAll() async {
    return await PlaceFavoritRepository().getAll();
  }

  ///Добавить место в список избранных
  void addPlace(PlaceFavorit place) => PlaceFavoritRepository().save(place);

  ///Удалить место из списка избранных
  void removePlace(PlaceFavorit place) =>
      PlaceFavoritRepository().deleteById(place.id);

  ///Перемещает place за after
  Future<void> move(PlaceFavorit after, PlaceFavorit place) async {
    final _after = await PlaceFavoritRepository().getById(after.id);
    place.sort = _after.sort + 1;
    await PlaceFavoritRepository().updateItem(place);
  }
}
