import 'dart:math';

class Sight {
  /// название достопримечательности
  String name = "";

  /// координаты места
  double lat = 0, lon = 0;

  ///путь до фотографии в интернете
  String url = "";

  ///описание достопримечательности
  String details = "";

  ///тип достопримечательности
  String type = "";

  ///Хочу посетить
  bool wontVisit = false;

  ///Посещал
  bool visit = false;

  Sight({this.name, this.lat, this.lon, this.url, this.details, this.type, this.wontVisit, this.visit});

  ///Возвращает кол-во метров от Sight до точки с координатами lat, lon
  double getDistans(double lat, double lon) {
    final double ky = 40000 / 0.36;
    final double kx = cos(pi * lat / 180) * ky;
    var dx = (lon - this.lon).abs() * kx;
    var dy = (lat - this.lat).abs() * ky;
    return sqrt(dx * dx + dy * dy);
  }
}
