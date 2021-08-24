import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/database/table/search_request.dart';

part 'database.g.dart';

@UseMoor(tables: [SearchRequests])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // TODO: пределать на отдельный класс
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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final file = File(join(dbPath.path, 'places.sql'));
    return VmDatabase(file);
  });
}
