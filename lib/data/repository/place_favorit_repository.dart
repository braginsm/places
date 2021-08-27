import 'dart:convert';

import 'package:places/data/model/place_favorit.dart';
import 'package:places/database/database.dart';

class PlaceFavoritRepository extends AppDb {
  DbPlaceFavorit _requestByPlaceFavorit(PlaceFavorit place) => DbPlaceFavorit(
        description: place.description,
        id: place.id,
        lat: place.lat,
        lon: place.lon,
        name: place.name,
        placeTypeId: place.placeType.index,
        sort: place.sort,
        urlsJson: jsonEncode(place.urls),
      );

  Future<void> save(PlaceFavorit place) async {
    final request = _requestByPlaceFavorit(place);
    try {
      final res = await (select(dbPlaceFavorits)
            ..where((tbl) => tbl.id.equals(place.id)))
          .getSingleOrNull();
      if (res == null) {
        into(dbPlaceFavorits).insert(request);
      } else {
        updateItem(place);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PlaceFavorit> getById(int id) async {
    try {
      final dbPlaceFavorit = await (select(dbPlaceFavorits)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return PlaceFavorit.fromDb(dbPlaceFavorit);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteById(int id) async {
    try {
      delete(dbPlaceFavorits).where((tbl) => tbl.id.equals(id));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItem(PlaceFavorit place) async {
    final request = _requestByPlaceFavorit(place);
    try {
      (update(dbPlaceFavorits)..where((tbl) => tbl.id.equals(place.id)))
          .replace(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PlaceFavorit>> getAll() async {
    try {
      return (await select(dbPlaceFavorits).get())
          .map((e) => PlaceFavorit.fromDb(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
