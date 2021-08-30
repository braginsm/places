import 'package:moor/moor.dart';

class DbPlaces extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get urlsJson => text()();
  TextColumn get description => text()();
  IntColumn get placeTypeId => integer()();

  @override
  Set<Column>? get primaryKey => {id};
}

class DbPlaceFavorits extends DbPlaces {
  IntColumn get sort => integer()();
}

class DbPlaceVisits extends DbPlaces {
  DateTimeColumn get dateVisit => dateTime()();
}
