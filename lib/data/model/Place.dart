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
      {this.description,
      this.id,
      this.lat,
      this.lon,
      this.name,
      this.placeType,
      this.urls});

  /// конструктор по данным
  Place.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        lat = data['lat'],
        lon = data['lon'],
        urls = (data['urls'] as List<dynamic>).map((e) => e.toString()).toList(),
        description = data['description'],
        placeType = EnumToString.fromString(PlaceType.values, data['placeType']);
}
