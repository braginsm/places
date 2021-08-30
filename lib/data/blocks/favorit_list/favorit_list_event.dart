import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_favorit.dart';

/// базовый эвент списка избранных мест
abstract class FavoritListEvent extends Equatable {
  const FavoritListEvent();

  @override
  List<Object?> get props => [];
}

/// событие начала закгрузки избранных мест
class FavoritListLoadEvent extends FavoritListEvent {}

/// событие добавления элемента списка в избранное
class VisitItemToFavoritEvent extends FavoritListEvent {
  final PlaceFavorit place;
  const VisitItemToFavoritEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

/// событие удаления элемента списка из избранного
class VisitItemRemoveFromFavoritEvent extends FavoritListEvent {
  final PlaceFavorit place;
  const VisitItemRemoveFromFavoritEvent(this.place) : super();

  @override
  List<Object?> get props => [place];
}

/// событие перемещения элемента
class FavoritItemMoveEvent extends FavoritListEvent {
  final PlaceFavorit after;
  final PlaceFavorit place;
  const FavoritItemMoveEvent(
    this.after, this.place,
  ) : super();

  @override
  List<Object> get props => [place];
}
