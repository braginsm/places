import 'package:moor/moor.dart';

class SearchRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get placeId => integer()();
  TextColumn get placeName => text()();
}
