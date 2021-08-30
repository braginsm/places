import 'package:moor/moor.dart';

class SearchRequests extends Table {
  IntColumn get placeId => integer()();
  TextColumn get placeName => text()();
  DateTimeColumn get dateInsert => dateTime()();
}
