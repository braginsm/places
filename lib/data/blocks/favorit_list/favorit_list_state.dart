import 'package:equatable/equatable.dart';
import 'package:places/data/model/Place.dart';

abstract class FavoritListState extends Equatable {
  const FavoritListState();

  @override
  List<Object> get props => [];
}

/// состояние загрузки данных
class FavoritListLoadingInProgress extends FavoritListState {}

/// состояние загруженных посещенных мест
class FavoritListLoadingSuccess extends FavoritListState {
  final List<Place> favoritList;

  FavoritListLoadingSuccess(this.favoritList);

  @override
  List<Object> get props => [favoritList];
}

