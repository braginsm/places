import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceRepository extends Repository {
  Future<Place> getById(String id) async {
    try {
      var res = await dio.get("/place/$id");
      return Place.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }
}
