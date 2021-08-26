// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SearchRequest extends DataClass implements Insertable<SearchRequest> {
  final int placeId;
  final String placeName;
  final DateTime dateInsert;
  SearchRequest(
      {required this.placeId,
      required this.placeName,
      required this.dateInsert});
  factory SearchRequest.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchRequest(
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id'])!,
      placeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_name'])!,
      dateInsert: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_insert'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<int>(placeId);
    map['place_name'] = Variable<String>(placeName);
    map['date_insert'] = Variable<DateTime>(dateInsert);
    return map;
  }

  SearchRequestsCompanion toCompanion(bool nullToAbsent) {
    return SearchRequestsCompanion(
      placeId: Value(placeId),
      placeName: Value(placeName),
      dateInsert: Value(dateInsert),
    );
  }

  factory SearchRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchRequest(
      placeId: serializer.fromJson<int>(json['placeId']),
      placeName: serializer.fromJson<String>(json['placeName']),
      dateInsert: serializer.fromJson<DateTime>(json['dateInsert']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'placeName': serializer.toJson<String>(placeName),
      'dateInsert': serializer.toJson<DateTime>(dateInsert),
    };
  }

  SearchRequest copyWith(
          {int? placeId, String? placeName, DateTime? dateInsert}) =>
      SearchRequest(
        placeId: placeId ?? this.placeId,
        placeName: placeName ?? this.placeName,
        dateInsert: dateInsert ?? this.dateInsert,
      );
  @override
  String toString() {
    return (StringBuffer('SearchRequest(')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('dateInsert: $dateInsert')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(placeId.hashCode, $mrjc(placeName.hashCode, dateInsert.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchRequest &&
          other.placeId == this.placeId &&
          other.placeName == this.placeName &&
          other.dateInsert == this.dateInsert);
}

class SearchRequestsCompanion extends UpdateCompanion<SearchRequest> {
  final Value<int> placeId;
  final Value<String> placeName;
  final Value<DateTime> dateInsert;
  const SearchRequestsCompanion({
    this.placeId = const Value.absent(),
    this.placeName = const Value.absent(),
    this.dateInsert = const Value.absent(),
  });
  SearchRequestsCompanion.insert({
    required int placeId,
    required String placeName,
    required DateTime dateInsert,
  })  : placeId = Value(placeId),
        placeName = Value(placeName),
        dateInsert = Value(dateInsert);
  static Insertable<SearchRequest> custom({
    Expression<int>? placeId,
    Expression<String>? placeName,
    Expression<DateTime>? dateInsert,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (placeName != null) 'place_name': placeName,
      if (dateInsert != null) 'date_insert': dateInsert,
    });
  }

  SearchRequestsCompanion copyWith(
      {Value<int>? placeId,
      Value<String>? placeName,
      Value<DateTime>? dateInsert}) {
    return SearchRequestsCompanion(
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      dateInsert: dateInsert ?? this.dateInsert,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (placeName.present) {
      map['place_name'] = Variable<String>(placeName.value);
    }
    if (dateInsert.present) {
      map['date_insert'] = Variable<DateTime>(dateInsert.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchRequestsCompanion(')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('dateInsert: $dateInsert')
          ..write(')'))
        .toString();
  }
}

class $SearchRequestsTable extends SearchRequests
    with TableInfo<$SearchRequestsTable, SearchRequest> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SearchRequestsTable(this._db, [this._alias]);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  late final GeneratedColumn<int?> placeId = GeneratedColumn<int?>(
      'place_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _placeNameMeta = const VerificationMeta('placeName');
  late final GeneratedColumn<String?> placeName = GeneratedColumn<String?>(
      'place_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _dateInsertMeta = const VerificationMeta('dateInsert');
  late final GeneratedColumn<DateTime?> dateInsert = GeneratedColumn<DateTime?>(
      'date_insert', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [placeId, placeName, dateInsert];
  @override
  String get aliasedName => _alias ?? 'search_requests';
  @override
  String get actualTableName => 'search_requests';
  @override
  VerificationContext validateIntegrity(Insertable<SearchRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('place_name')) {
      context.handle(_placeNameMeta,
          placeName.isAcceptableOrUnknown(data['place_name']!, _placeNameMeta));
    } else if (isInserting) {
      context.missing(_placeNameMeta);
    }
    if (data.containsKey('date_insert')) {
      context.handle(
          _dateInsertMeta,
          dateInsert.isAcceptableOrUnknown(
              data['date_insert']!, _dateInsertMeta));
    } else if (isInserting) {
      context.missing(_dateInsertMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  SearchRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchRequest.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchRequestsTable createAlias(String alias) {
    return $SearchRequestsTable(_db, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchRequestsTable searchRequests = $SearchRequestsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [searchRequests];
}
