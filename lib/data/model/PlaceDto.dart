import 'package:enum_to_string/enum_to_string.dart';
import 'package:places/data/model/Place.dart';

///Модель данных ответа на запрос фильтра мест. От модели данных места Place отличается наличием поля distance, в котором при ответе будет расстояние от запрошенной точки
class PlaceDto {
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

  ///расстояние от запрошенной точки
  final double distance;

  /// конструктор
  PlaceDto(
      {this.description,
      this.id,
      this.lat,
      this.lon,
      this.name,
      this.placeType,
      this.urls,
      this.distance});

  /// конструктор по данным
  PlaceDto.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        lat = data['lat'],
        lon = data['lon'],
        urls = (data['urls'] as List<dynamic>).map((e) => e.toString()).toList(),
        description = data['description'],
        distance = data['distance'],
        placeType =
            EnumToString.fromString(PlaceType.values, data['placeType']);
}
