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
  int id = 0;

  /// название достопримечательности
  String name = "";

  /// широта места
  double lat = 0;

  /// долгота места
  double lon = 0;

  ///путь до фотографии в интернете
  List<String> urls = [];

  ///описание достопримечательности
  String description = "";

  ///тип достопримечательности
  PlaceType placeType = PlaceType.other;

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
        urls = data['urls'],
        description = data['description'],
        placeType = EnumToString.fromString(PlaceType.values, data['placeType']);
}
