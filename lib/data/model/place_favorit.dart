import 'dart:convert';

import 'package:places/database/database.dart';

import 'place.dart';

class PlaceFavorit extends Place {
  late final int sort;
  PlaceFavorit.fromPlace(Place place, this.sort)
      : super(
          description: place.description,
          id: place.id,
          lat: place.lat,
          lon: place.lon,
          name: place.name,
          placeType: place.placeType,
          urls: place.urls,
        );

  PlaceFavorit.fromDb(DbPlaceFavorit dbPlacesFavorit)
      : super(
          description: dbPlacesFavorit.description,
          id: dbPlacesFavorit.id,
          lat: dbPlacesFavorit.lat,
          lon: dbPlacesFavorit.lon,
          name: dbPlacesFavorit.name,
          placeType: PlaceType.values[dbPlacesFavorit.placeTypeId],
          urls: jsonDecode(dbPlacesFavorit.urlsJson) as List<String>,
        ) {
          sort = dbPlacesFavorit.sort;
        }
}
