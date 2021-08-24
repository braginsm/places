// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SearchRequest extends DataClass implements Insertable<SearchRequest> {
  final int id;
  final int placeId;
  final String placeName;
  final String placeImage;
  SearchRequest(
      {required this.id,
      required this.placeId,
      required this.placeName,
      required this.placeImage});
  factory SearchRequest.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchRequest(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id'])!,
      placeName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_name'])!,
      placeImage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_image'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['place_name'] = Variable<String>(placeName);
    map['place_image'] = Variable<String>(placeImage);
    return map;
  }

  SearchRequestsCompanion toCompanion(bool nullToAbsent) {
    return SearchRequestsCompanion(
      id: Value(id),
      placeId: Value(placeId),
      placeName: Value(placeName),
      placeImage: Value(placeImage),
    );
  }

  factory SearchRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchRequest(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      placeName: serializer.fromJson<String>(json['placeName']),
      placeImage: serializer.fromJson<String>(json['placeImage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'placeName': serializer.toJson<String>(placeName),
      'placeImage': serializer.toJson<String>(placeImage),
    };
  }

  SearchRequest copyWith(
          {int? id, int? placeId, String? placeName, String? placeImage}) =>
      SearchRequest(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        placeName: placeName ?? this.placeName,
        placeImage: placeImage ?? this.placeImage,
      );
  @override
  String toString() {
    return (StringBuffer('SearchRequest(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('placeImage: $placeImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(placeId.hashCode, $mrjc(placeName.hashCode, placeImage.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchRequest &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.placeName == this.placeName &&
          other.placeImage == this.placeImage);
}

class SearchRequestsCompanion extends UpdateCompanion<SearchRequest> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> placeName;
  final Value<String> placeImage;
  const SearchRequestsCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.placeName = const Value.absent(),
    this.placeImage = const Value.absent(),
  });
  SearchRequestsCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String placeName,
    required String placeImage,
  })  : placeId = Value(placeId),
        placeName = Value(placeName),
        placeImage = Value(placeImage);
  static Insertable<SearchRequest> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? placeName,
    Expression<String>? placeImage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (placeName != null) 'place_name': placeName,
      if (placeImage != null) 'place_image': placeImage,
    });
  }

  SearchRequestsCompanion copyWith(
      {Value<int>? id,
      Value<int>? placeId,
      Value<String>? placeName,
      Value<String>? placeImage}) {
    return SearchRequestsCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      placeImage: placeImage ?? this.placeImage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (placeName.present) {
      map['place_name'] = Variable<String>(placeName.value);
    }
    if (placeImage.present) {
      map['place_image'] = Variable<String>(placeImage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchRequestsCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('placeName: $placeName, ')
          ..write('placeImage: $placeImage')
          ..write(')'))
        .toString();
  }
}

class $SearchRequestsTable extends SearchRequests
    with TableInfo<$SearchRequestsTable, SearchRequest> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SearchRequestsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  late final GeneratedColumn<int?> placeId = GeneratedColumn<int?>(
      'place_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _placeNameMeta = const VerificationMeta('placeName');
  late final GeneratedColumn<String?> placeName = GeneratedColumn<String?>(
      'place_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _placeImageMeta = const VerificationMeta('placeImage');
  late final GeneratedColumn<String?> placeImage = GeneratedColumn<String?>(
      'place_image', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, placeId, placeName, placeImage];
  @override
  String get aliasedName => _alias ?? 'search_requests';
  @override
  String get actualTableName => 'search_requests';
  @override
  VerificationContext validateIntegrity(Insertable<SearchRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
    if (data.containsKey('place_image')) {
      context.handle(
          _placeImageMeta,
          placeImage.isAcceptableOrUnknown(
              data['place_image']!, _placeImageMeta));
    } else if (isInserting) {
      context.missing(_placeImageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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
