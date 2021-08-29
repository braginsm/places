import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_favorit.dart';
import 'package:places/data/repository/place_favorit_repository.dart';

class PlaceFavoritInteractor {
  Future<List<PlaceFavorit>> getAll() async {
    return await PlaceFavoritRepository().getAll();
  }

  Future<PlaceFavorit?> getById(int id) {
    return PlaceFavoritRepository().getById(id);
  }

  ///Добавить место в список избранных
  void addPlace(PlaceFavorit place) => PlaceFavoritRepository().save(place);

  ///Удалить место из списка избранных
  void removePlace(PlaceFavorit place) =>
      PlaceFavoritRepository().delete(place);

  ///Перемещает place за after
  Future<void> move(PlaceFavorit after, PlaceFavorit place) async {
    final _after = await PlaceFavoritRepository().getById(after.id);
    if (_after == null) throw ArgumentError();
    place.sort = _after.sort + 1;
    await PlaceFavoritRepository().updateItem(place);
  }

  Future<bool> inFavorit(Place place) async {
    try {
      final _list = await PlaceFavoritRepository().getAll();
      return _list.any((element) => element.id == place.id);
    } catch (_) {
      return false;
    }
  }
}
