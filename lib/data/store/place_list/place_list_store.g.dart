// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  final _$getPlaceListFutureAtom =
      Atom(name: 'PlaceListStoreBase.getPlaceListFuture');

  @override
  ObservableFuture<List<Place>> get getPlaceListFuture {
    _$getPlaceListFutureAtom.reportRead();
    return super.getPlaceListFuture;
  }

  @override
  set getPlaceListFuture(ObservableFuture<List<Place>> value) {
    _$getPlaceListFutureAtom.reportWrite(value, super.getPlaceListFuture, () {
      super.getPlaceListFuture = value;
    });
  }

  final _$PlaceListStoreBaseActionController =
      ActionController(name: 'PlaceListStoreBase');

  @override
  void getPlaceList() {
    final _$actionInfo = _$PlaceListStoreBaseActionController.startAction(
        name: 'PlaceListStoreBase.getPlaceList');
    try {
      return super.getPlaceList();
    } finally {
      _$PlaceListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getPlaceListFuture: ${getPlaceListFuture}
    ''';
  }
}
