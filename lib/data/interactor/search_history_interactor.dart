import 'package:moor/moor.dart';
import 'package:places/data/model/place.dart';

import '../../database/database.dart';

class SearchHistoryInteractor extends AppDb {
  SearchHistoryInteractor() : super();

  Future<List<SearchRequest>> get allSearchRequestEntries =>
      select(searchRequests).get();

  Future<void> saveSearchRequest(Place place) async {
    final request = SearchRequest(
      placeId: place.id,
      placeName: place.name,
      dateInsert: DateTime.now(),
    );
    final res = await (select(searchRequests)
          ..where((tbl) => tbl.placeId.equals(place.id)))
        .getSingleOrNull();
    if (res == null) {
      into(searchRequests).insert(request);
    } else {
      (update(searchRequests)..where((tbl) => tbl.placeId.equals(place.id))).write(request);
    }
  }

  Future<void> deleteSearchRequest(int placeId) async {
    return delete(searchRequests).where((tbl) => tbl.placeId.equals(placeId));
  }

  Future<void> clearSearchHistory() async {
    return delete(searchRequests).where((tbl) => tbl.placeId.isNotNull());
  }
}
