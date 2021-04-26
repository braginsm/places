import 'dart:math';

class Sight {
  /// название достопримечательности
  String name = "";

  /// координаты места
  double lat = 0, lon = 0;

  ///путь до фотографии в интернете
  List<String> url = [];

  ///описание достопримечательности
  String details = "";

  ///тип достопримечательности
  String type = "";

  ///Хочу посетить в дату
  DateTime wontDate;

  ///Посещал
  DateTime visitDate;

  Sight(
      {this.name,
      this.lat,
      this.lon,
      this.url,
      this.details,
      this.type,
      this.wontDate,
      this.visitDate});

  ///Возвращает кол-во метров от Sight до точки с координатами lat, lon
  double getDistans(double lat, double lon) {
    final double ky = 40000 / 0.36;
    final double kx = cos(pi * lat / 180) * ky;
    var dx = (lon - this.lon).abs() * kx;
    var dy = (lat - this.lat).abs() * ky;
    return sqrt(dx * dx + dy * dy);
  }

  //геттеры 
  bool get wontVisit => wontDate != null && wontDate.difference(DateTime.now()).inDays >= 0;
  bool get visit => visitDate != null && visitDate.difference(DateTime.now()).inDays <= 0;
}
