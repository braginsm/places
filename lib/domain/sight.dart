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
}
