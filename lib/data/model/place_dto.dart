import 'package:places/data/model/place.dart';

///Модель данных ответа на запрос фильтра мест. От модели данных места Place отличается наличием поля distance, в котором при ответе будет расстояние от запрошенной точки
class PlaceDto extends Place {
  ///расстояние от запрошенной точки
  double? distance;

  /// конструктор
  PlaceDto(
      {required String description,
      required int id,
      required double lat,
      required double lon,
      required String name,
      required PlaceType placeType,
      required List<String> urls,
      this.distance})
      : super(
            description: description,
            id: id,
            lat: lat,
            lon: lon,
            name: name,
            placeType: placeType,
            urls: urls);

  /// конструктор по данным
  PlaceDto.fromJson(Map<String, dynamic> data)
      : super.fromJson(data) {
        distance = data['distance'];
      }
}
