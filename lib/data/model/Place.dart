import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';

enum PlaceType {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other
}

class Place {
  /// id места
  final int id;

  /// название достопримечательности
  final String name;

  /// широта места
  final double lat;

  /// долгота места
  final double lon;

  ///путь до фотографии в интернете
  final List<String> urls;

  ///описание достопримечательности
  final String description;

  ///тип достопримечательности
  final PlaceType placeType;

  /// конструктор
  Place(
      {this.description = "",
      this.id = 0,
      this.lat = .0,
      this.lon = .0,
      required this.name,
      this.placeType = PlaceType.temple,
      this.urls = const []});

  /// конструктор по данным
  Place.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        lat = data['lat'],
        lon = data['lon'],
        urls =
            (data['urls'] as List<dynamic>).map((e) => e.toString()).toList(),
        description = data['description'],
        placeType =
            EnumToString.fromString(PlaceType.values, data['placeType']) ?? PlaceType.temple;

  Place copyWith({int? id, String? name, double? lat, double? lon, List<String>? urls, String? description, PlaceType? placeType}) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      urls: urls ?? this.urls,
      description: description ?? this.description,
      placeType: placeType ?? this.placeType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "lat": lat,
      "lng": lon,
      "urls": urls,
      "description": description,
      "placeType": EnumToString.convertToString(placeType),
    };
  }

  ///Возвращает кол-во метров от Place до точки с координатами lat, lon
  double getDistans(double currentLat, double currentlon) {
    const double ky = 40000 / 0.36;
    final double kx = cos(pi * lat / 180) * ky;
    var dx = (currentLat - lon).abs() * kx;
    var dy = (currentlon - lat).abs() * ky;
    return sqrt(dx * dx + dy * dy);
  }

  static final List<String> ruPlaceTypeNames = [
    "храм",
    "памятник",
    "парк",
    "театр",
    "музей",
    "отель",
    "ресторан",
    "кафе",
    "другое"
  ];

  String get placeTypeName => ruPlaceTypeNames.elementAt(placeType.index);
}
