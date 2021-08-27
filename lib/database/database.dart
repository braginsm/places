import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'table/search_request.dart';
import 'table/db_place.dart';

part 'database.g.dart';

@UseMoor(tables: [SearchRequests, DbPlaceFavorits, DbPlaceVisits])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final file = File(join(dbPath.path, 'places.sql'));
    return VmDatabase(file);
  });
}
