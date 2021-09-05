import 'package:places/data/model/geo.dart';
import 'package:places/data/repository/geo_repository.dart';

class GeoInteractor {
  Future<Geo> get currentPosition async => await GeoRepository().determinePosition();
}
