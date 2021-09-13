import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';

import 'geo.dart';

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
        lon = data['lng'],
        urls =
            (data['urls'] as List<dynamic>).map((e) => e.toString()).toList(),
        description = data['description'],
        placeType =
            EnumToString.fromString(PlaceType.values, data['placeType']) ??
                PlaceType.temple;

  Place copyWith(
      {int? id,
      String? name,
      double? lat,
      double? lon,
      List<String>? urls,
      String? description,
      PlaceType? placeType}) {
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
  double getDistans(Geo geo) {
    // перевести координаты в радианы
    final lat1 = lat * pi / 180;
    final lat2 = geo.latitude * pi / 180;
    final long1 = lon * pi / 180;
    final long2 = geo.longitude * pi / 180;

    // косинусы и синусы широт и разницы долгот
    final cl1 = cos(lat1);
    final cl2 = cos(lat2);
    final sl1 = sin(lat1);
    final sl2 = sin(lat2);
    final delta = long2 - long1;
    final cdelta = cos(delta);
    final sdelta = sin(delta);

    // вычисления длины большого круга
    final y =
        sqrt(pow(cl2 * sdelta, 2) + pow(cl1 * sl2 - sl1 * cl2 * cdelta, 2));
    final x = sl1 * sl2 + cl1 * cl2 * cdelta;
    final ad = atan2(y, x);

    return ad * 6372795; // 6372795 - радиус земли
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

  String get key => "place_$id";
}
