import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/PlaceRepository.dart';

/// мок места положения
final double currentLat = 56.84987946580704;
final double currentLon = 53.247889685270756;

class PlaceInteractor {
  Future<List<Place>> getPlaces(int radius, String category) async {
    return await PlaceRepository().getByParameters(
      offset: radius,
    );
  }
}
