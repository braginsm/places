import 'dart:convert';

import 'package:places/data/model/place_visit.dart';
import 'package:places/database/database.dart';

class PlaceVisitRepository extends AppDb {
  DbPlaceVisit _requestByPlaceVisit(PlaceVisit place) => DbPlaceVisit(
        description: place.description,
        id: place.id,
        lat: place.lat,
        lon: place.lon,
        name: place.name,
        placeTypeId: place.placeType.index,
        urlsJson: jsonEncode(place.urls), 
        dateVisit: place.dateVisit,
      );

  Future<void> save(PlaceVisit place) async {
    final request = _requestByPlaceVisit(place);
    try {
      final res = await (select(dbPlaceVisits)
            ..where((tbl) => tbl.id.equals(place.id)))
          .getSingleOrNull();
      if (res == null) {
        into(dbPlaceVisits).insert(request);
      } else {
        updateItem(place);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PlaceVisit> getById(int id) async {
    try {
      final dbPlaceVisit = await (select(dbPlaceVisits)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return PlaceVisit.fromDb(dbPlaceVisit);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteById(int id) async {
    try {
      delete(dbPlaceVisits).where((tbl) => tbl.id.equals(id));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItem(PlaceVisit place) async {
    final request = _requestByPlaceVisit(place);
    try {
      (update(dbPlaceVisits)..where((tbl) => tbl.id.equals(place.id)))
          .replace(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PlaceVisit>> getAll() async {
    try {
      return (await select(dbPlaceVisits).get())
          .map((e) => PlaceVisit.fromDb(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
