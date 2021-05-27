import 'package:enum_to_string/enum_to_string.dart';
import 'package:places/data/model/Place.dart';

class PlacesFilterRequestDto {
  ///Модель данных с параметрами фильтра. Все поля не обязательные, но параметры "lat", "lat" и "radius" зависят друг от друга, поэтому если указан один из них, то остальные два становятся обязательными

  ///Широта
  double lat;

  ///Долгота
  double lon;

  ///Радиус поиска в метрах
  double radius;

  ///Фильтр со списком типов мест
  List<String> typeFilter;

  ///Фильтр по наименованию места
  String nameFilter;

  PlacesFilterRequestDto(
      {this.lat, this.lon, this.nameFilter, this.radius, this.typeFilter});

  PlacesFilterRequestDto.fromJson(Map<String, dynamic> data)
      : lat = data['lat'],
        lon = data['lon'],
        radius = data['radius'],
        typeFilter = data['typeFilter'].map((element) => EnumToString.fromString(PlaceType.values, element)).toList(),
        nameFilter = data['nameFilter'];

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lon,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }
}
