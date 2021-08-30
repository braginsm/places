import 'package:places/data/model/place.dart';

import '../../database/database.dart';

class SearchHistoryInteractor {
  SearchHistoryInteractor() : super();

  Future<List<SearchRequest>> get allSearchRequestEntries =>
      dbConnection.select(dbConnection.searchRequests).get();

  Future<void> saveSearchRequest(Place place) async {
    final request = SearchRequest(
      placeId: place.id,
      placeName: place.name,
      dateInsert: DateTime.now(),
    );
    final res = await (dbConnection.select(dbConnection.searchRequests)
          ..where((tbl) => tbl.placeId.equals(place.id)))
        .getSingleOrNull();
    if (res == null) {
      dbConnection.into(dbConnection.searchRequests).insert(request);
    } else {
      (dbConnection.update(dbConnection.searchRequests)..where((tbl) => tbl.placeId.equals(place.id))).write(request);
    }
  }

  Future<void> deleteSearchRequest(int id) async {
    return dbConnection.customStatement('DELETE FROM search_requests WHERE place_id = $id');
  }

  Future<int> clearSearchHistory() async {
    return dbConnection.delete(dbConnection.searchRequests).go();
  }
}
