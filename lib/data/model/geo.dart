import 'package:geolocator/geolocator.dart';

class Geo {
  /// Штрота
  final double latitude;

  /// Долгота
  final double longitude;

  Geo(this.latitude, this.longitude);

  Geo.fromPosition(Position position)
      : latitude = position.latitude,
        longitude = position.longitude;
}
