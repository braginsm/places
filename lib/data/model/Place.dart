class Place {
  /// id места
  String id = "";

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
  String placeType = "";

  Place.fromJson(Map<String, dynamic> data):
    id = data['id'],
    name = data['name'],
    lat = data['lat'],
    lon = data['lon'],
    urls = data['urls'],
    description = data['description'],
    placeType = data['placeType'];
}
