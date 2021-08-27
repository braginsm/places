import 'dart:convert';

import 'package:places/database/database.dart';

import 'place.dart';

class PlaceVisit extends Place {
  late final DateTime dateVisit;
  PlaceVisit.fromPlace(Place place, this.dateVisit)
      : super(
          description: place.description,
          id: place.id,
          lat: place.lat,
          lon: place.lon,
          name: place.name,
          placeType: place.placeType,
          urls: place.urls,
        );

  PlaceVisit.fromDb(DbPlaceVisit dbPlacesVisit)
      : super(
          description: dbPlacesVisit.description,
          id: dbPlacesVisit.id,
          lat: dbPlacesVisit.lat,
          lon: dbPlacesVisit.lon,
          name: dbPlacesVisit.name,
          placeType: PlaceType.values[dbPlacesVisit.placeTypeId],
          urls: jsonDecode(dbPlacesVisit.urlsJson) as List<String>,
        ) {
          dateVisit = dbPlacesVisit.dateVisit;
        }
}
