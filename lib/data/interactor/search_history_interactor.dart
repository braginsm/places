import 'package:moor/moor.dart';

import '../../database/database.dart';

class SearchHistoryInteractor extends AppDb {
  SearchHistoryInteractor() : super();

  Future<List<SearchRequest>> get allSearchRequestEntries =>
      select(searchRequests).get();

  Future<int> saveSearchRequest(SearchRequestsCompanion requests) {
    return into(searchRequests).insert(requests);
  }

  Future<void> deleteSearchRequest(int placeId) async {
    return delete(searchRequests).where((tbl) => tbl.placeId.equals(placeId));
  }

  Future<void> clearSearchHistory() async {
    return delete(searchRequests).where((tbl) => tbl.placeId.isNotNull());
  }
}
