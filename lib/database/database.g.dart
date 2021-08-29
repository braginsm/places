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

class DbPlaceFavorit extends DataClass implements Insertable<DbPlaceFavorit> {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final String urlsJson;
  final String description;
  final int placeTypeId;
  final int sort;
  DbPlaceFavorit(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon,
      required this.urlsJson,
      required this.description,
      required this.placeTypeId,
      required this.sort});
  factory DbPlaceFavorit.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbPlaceFavorit(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lon: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lon'])!,
      urlsJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}urls_json'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      placeTypeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type_id'])!,
      sort: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sort'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['urls_json'] = Variable<String>(urlsJson);
    map['description'] = Variable<String>(description);
    map['place_type_id'] = Variable<int>(placeTypeId);
    map['sort'] = Variable<int>(sort);
    return map;
  }

  DbPlaceFavoritsCompanion toCompanion(bool nullToAbsent) {
    return DbPlaceFavoritsCompanion(
      id: Value(id),
      name: Value(name),
      lat: Value(lat),
      lon: Value(lon),
      urlsJson: Value(urlsJson),
      description: Value(description),
      placeTypeId: Value(placeTypeId),
      sort: Value(sort),
    );
  }

  factory DbPlaceFavorit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbPlaceFavorit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      urlsJson: serializer.fromJson<String>(json['urlsJson']),
      description: serializer.fromJson<String>(json['description']),
      placeTypeId: serializer.fromJson<int>(json['placeTypeId']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'urlsJson': serializer.toJson<String>(urlsJson),
      'description': serializer.toJson<String>(description),
      'placeTypeId': serializer.toJson<int>(placeTypeId),
      'sort': serializer.toJson<int>(sort),
    };
  }

  DbPlaceFavorit copyWith(
          {int? id,
          String? name,
          double? lat,
          double? lon,
          String? urlsJson,
          String? description,
          int? placeTypeId,
          int? sort}) =>
      DbPlaceFavorit(
        id: id ?? this.id,
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        urlsJson: urlsJson ?? this.urlsJson,
        description: description ?? this.description,
        placeTypeId: placeTypeId ?? this.placeTypeId,
        sort: sort ?? this.sort,
      );
  @override
  String toString() {
    return (StringBuffer('DbPlaceFavorit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('urlsJson: $urlsJson, ')
          ..write('description: $description, ')
          ..write('placeTypeId: $placeTypeId, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              lat.hashCode,
              $mrjc(
                  lon.hashCode,
                  $mrjc(
                      urlsJson.hashCode,
                      $mrjc(description.hashCode,
                          $mrjc(placeTypeId.hashCode, sort.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPlaceFavorit &&
          other.id == this.id &&
          other.name == this.name &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.urlsJson == this.urlsJson &&
          other.description == this.description &&
          other.placeTypeId == this.placeTypeId &&
          other.sort == this.sort);
}

class DbPlaceFavoritsCompanion extends UpdateCompanion<DbPlaceFavorit> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> lat;
  final Value<double> lon;
  final Value<String> urlsJson;
  final Value<String> description;
  final Value<int> placeTypeId;
  final Value<int> sort;
  const DbPlaceFavoritsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.urlsJson = const Value.absent(),
    this.description = const Value.absent(),
    this.placeTypeId = const Value.absent(),
    this.sort = const Value.absent(),
  });
  DbPlaceFavoritsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double lat,
    required double lon,
    required String urlsJson,
    required String description,
    required int placeTypeId,
    required int sort,
  })  : name = Value(name),
        lat = Value(lat),
        lon = Value(lon),
        urlsJson = Value(urlsJson),
        description = Value(description),
        placeTypeId = Value(placeTypeId),
        sort = Value(sort);
  static Insertable<DbPlaceFavorit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? urlsJson,
    Expression<String>? description,
    Expression<int>? placeTypeId,
    Expression<int>? sort,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (urlsJson != null) 'urls_json': urlsJson,
      if (description != null) 'description': description,
      if (placeTypeId != null) 'place_type_id': placeTypeId,
      if (sort != null) 'sort': sort,
    });
  }

  DbPlaceFavoritsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? lat,
      Value<double>? lon,
      Value<String>? urlsJson,
      Value<String>? description,
      Value<int>? placeTypeId,
      Value<int>? sort}) {
    return DbPlaceFavoritsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      urlsJson: urlsJson ?? this.urlsJson,
      description: description ?? this.description,
      placeTypeId: placeTypeId ?? this.placeTypeId,
      sort: sort ?? this.sort,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (urlsJson.present) {
      map['urls_json'] = Variable<String>(urlsJson.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (placeTypeId.present) {
      map['place_type_id'] = Variable<int>(placeTypeId.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPlaceFavoritsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('urlsJson: $urlsJson, ')
          ..write('description: $description, ')
          ..write('placeTypeId: $placeTypeId, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }
}

class $DbPlaceFavoritsTable extends DbPlaceFavorits
    with TableInfo<$DbPlaceFavoritsTable, DbPlaceFavorit> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DbPlaceFavoritsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _lonMeta = const VerificationMeta('lon');
  late final GeneratedColumn<double?> lon = GeneratedColumn<double?>(
      'lon', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _urlsJsonMeta = const VerificationMeta('urlsJson');
  late final GeneratedColumn<String?> urlsJson = GeneratedColumn<String?>(
      'urls_json', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _placeTypeIdMeta =
      const VerificationMeta('placeTypeId');
  late final GeneratedColumn<int?> placeTypeId = GeneratedColumn<int?>(
      'place_type_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _sortMeta = const VerificationMeta('sort');
  late final GeneratedColumn<int?> sort = GeneratedColumn<int?>(
      'sort', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lat, lon, urlsJson, description, placeTypeId, sort];
  @override
  String get aliasedName => _alias ?? 'db_place_favorits';
  @override
  String get actualTableName => 'db_place_favorits';
  @override
  VerificationContext validateIntegrity(Insertable<DbPlaceFavorit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
          _lonMeta, lon.isAcceptableOrUnknown(data['lon']!, _lonMeta));
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('urls_json')) {
      context.handle(_urlsJsonMeta,
          urlsJson.isAcceptableOrUnknown(data['urls_json']!, _urlsJsonMeta));
    } else if (isInserting) {
      context.missing(_urlsJsonMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('place_type_id')) {
      context.handle(
          _placeTypeIdMeta,
          placeTypeId.isAcceptableOrUnknown(
              data['place_type_id']!, _placeTypeIdMeta));
    } else if (isInserting) {
      context.missing(_placeTypeIdMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort']!, _sortMeta));
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPlaceFavorit map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbPlaceFavorit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DbPlaceFavoritsTable createAlias(String alias) {
    return $DbPlaceFavoritsTable(_db, alias);
  }
}

class DbPlaceVisit extends DataClass implements Insertable<DbPlaceVisit> {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final String urlsJson;
  final String description;
  final int placeTypeId;
  final DateTime dateVisit;
  DbPlaceVisit(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon,
      required this.urlsJson,
      required this.description,
      required this.placeTypeId,
      required this.dateVisit});
  factory DbPlaceVisit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbPlaceVisit(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lon: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lon'])!,
      urlsJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}urls_json'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      placeTypeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type_id'])!,
      dateVisit: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_visit'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['urls_json'] = Variable<String>(urlsJson);
    map['description'] = Variable<String>(description);
    map['place_type_id'] = Variable<int>(placeTypeId);
    map['date_visit'] = Variable<DateTime>(dateVisit);
    return map;
  }

  DbPlaceVisitsCompanion toCompanion(bool nullToAbsent) {
    return DbPlaceVisitsCompanion(
      id: Value(id),
      name: Value(name),
      lat: Value(lat),
      lon: Value(lon),
      urlsJson: Value(urlsJson),
      description: Value(description),
      placeTypeId: Value(placeTypeId),
      dateVisit: Value(dateVisit),
    );
  }

  factory DbPlaceVisit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DbPlaceVisit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      urlsJson: serializer.fromJson<String>(json['urlsJson']),
      description: serializer.fromJson<String>(json['description']),
      placeTypeId: serializer.fromJson<int>(json['placeTypeId']),
      dateVisit: serializer.fromJson<DateTime>(json['dateVisit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'urlsJson': serializer.toJson<String>(urlsJson),
      'description': serializer.toJson<String>(description),
      'placeTypeId': serializer.toJson<int>(placeTypeId),
      'dateVisit': serializer.toJson<DateTime>(dateVisit),
    };
  }

  DbPlaceVisit copyWith(
          {int? id,
          String? name,
          double? lat,
          double? lon,
          String? urlsJson,
          String? description,
          int? placeTypeId,
          DateTime? dateVisit}) =>
      DbPlaceVisit(
        id: id ?? this.id,
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        urlsJson: urlsJson ?? this.urlsJson,
        description: description ?? this.description,
        placeTypeId: placeTypeId ?? this.placeTypeId,
        dateVisit: dateVisit ?? this.dateVisit,
      );
  @override
  String toString() {
    return (StringBuffer('DbPlaceVisit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('urlsJson: $urlsJson, ')
          ..write('description: $description, ')
          ..write('placeTypeId: $placeTypeId, ')
          ..write('dateVisit: $dateVisit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              lat.hashCode,
              $mrjc(
                  lon.hashCode,
                  $mrjc(
                      urlsJson.hashCode,
                      $mrjc(
                          description.hashCode,
                          $mrjc(
                              placeTypeId.hashCode, dateVisit.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPlaceVisit &&
          other.id == this.id &&
          other.name == this.name &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.urlsJson == this.urlsJson &&
          other.description == this.description &&
          other.placeTypeId == this.placeTypeId &&
          other.dateVisit == this.dateVisit);
}

class DbPlaceVisitsCompanion extends UpdateCompanion<DbPlaceVisit> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> lat;
  final Value<double> lon;
  final Value<String> urlsJson;
  final Value<String> description;
  final Value<int> placeTypeId;
  final Value<DateTime> dateVisit;
  const DbPlaceVisitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.urlsJson = const Value.absent(),
    this.description = const Value.absent(),
    this.placeTypeId = const Value.absent(),
    this.dateVisit = const Value.absent(),
  });
  DbPlaceVisitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double lat,
    required double lon,
    required String urlsJson,
    required String description,
    required int placeTypeId,
    required DateTime dateVisit,
  })  : name = Value(name),
        lat = Value(lat),
        lon = Value(lon),
        urlsJson = Value(urlsJson),
        description = Value(description),
        placeTypeId = Value(placeTypeId),
        dateVisit = Value(dateVisit);
  static Insertable<DbPlaceVisit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? urlsJson,
    Expression<String>? description,
    Expression<int>? placeTypeId,
    Expression<DateTime>? dateVisit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (urlsJson != null) 'urls_json': urlsJson,
      if (description != null) 'description': description,
      if (placeTypeId != null) 'place_type_id': placeTypeId,
      if (dateVisit != null) 'date_visit': dateVisit,
    });
  }

  DbPlaceVisitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? lat,
      Value<double>? lon,
      Value<String>? urlsJson,
      Value<String>? description,
      Value<int>? placeTypeId,
      Value<DateTime>? dateVisit}) {
    return DbPlaceVisitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      urlsJson: urlsJson ?? this.urlsJson,
      description: description ?? this.description,
      placeTypeId: placeTypeId ?? this.placeTypeId,
      dateVisit: dateVisit ?? this.dateVisit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (urlsJson.present) {
      map['urls_json'] = Variable<String>(urlsJson.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (placeTypeId.present) {
      map['place_type_id'] = Variable<int>(placeTypeId.value);
    }
    if (dateVisit.present) {
      map['date_visit'] = Variable<DateTime>(dateVisit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPlaceVisitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('urlsJson: $urlsJson, ')
          ..write('description: $description, ')
          ..write('placeTypeId: $placeTypeId, ')
          ..write('dateVisit: $dateVisit')
          ..write(')'))
        .toString();
  }
}

class $DbPlaceVisitsTable extends DbPlaceVisits
    with TableInfo<$DbPlaceVisitsTable, DbPlaceVisit> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DbPlaceVisitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _lonMeta = const VerificationMeta('lon');
  late final GeneratedColumn<double?> lon = GeneratedColumn<double?>(
      'lon', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _urlsJsonMeta = const VerificationMeta('urlsJson');
  late final GeneratedColumn<String?> urlsJson = GeneratedColumn<String?>(
      'urls_json', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _placeTypeIdMeta =
      const VerificationMeta('placeTypeId');
  late final GeneratedColumn<int?> placeTypeId = GeneratedColumn<int?>(
      'place_type_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _dateVisitMeta = const VerificationMeta('dateVisit');
  late final GeneratedColumn<DateTime?> dateVisit = GeneratedColumn<DateTime?>(
      'date_visit', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, lat, lon, urlsJson, description, placeTypeId, dateVisit];
  @override
  String get aliasedName => _alias ?? 'db_place_visits';
  @override
  String get actualTableName => 'db_place_visits';
  @override
  VerificationContext validateIntegrity(Insertable<DbPlaceVisit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
          _lonMeta, lon.isAcceptableOrUnknown(data['lon']!, _lonMeta));
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('urls_json')) {
      context.handle(_urlsJsonMeta,
          urlsJson.isAcceptableOrUnknown(data['urls_json']!, _urlsJsonMeta));
    } else if (isInserting) {
      context.missing(_urlsJsonMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('place_type_id')) {
      context.handle(
          _placeTypeIdMeta,
          placeTypeId.isAcceptableOrUnknown(
              data['place_type_id']!, _placeTypeIdMeta));
    } else if (isInserting) {
      context.missing(_placeTypeIdMeta);
    }
    if (data.containsKey('date_visit')) {
      context.handle(_dateVisitMeta,
          dateVisit.isAcceptableOrUnknown(data['date_visit']!, _dateVisitMeta));
    } else if (isInserting) {
      context.missing(_dateVisitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPlaceVisit map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbPlaceVisit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DbPlaceVisitsTable createAlias(String alias) {
    return $DbPlaceVisitsTable(_db, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchRequestsTable searchRequests = $SearchRequestsTable(this);
  late final $DbPlaceFavoritsTable dbPlaceFavorits =
      $DbPlaceFavoritsTable(this);
  late final $DbPlaceVisitsTable dbPlaceVisits = $DbPlaceVisitsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchRequests, dbPlaceFavorits, dbPlaceVisits];
}
