import 'package:equatable/equatable.dart';
import 'package:places/data/model/Place.dart';

/// базовый эвент списка избранных мест
abstract class FavoritListEvent extends Equatable {
  const FavoritListEvent();

  @override
  List<Object> get props => [];
}

/// событие начала закгрузки избранных мест
class FavoritListLoadEvent extends FavoritListEvent {}

/// событие добавления элемента списка в избранное
class VisitItemToFavoritEvent extends FavoritListEvent {
  final Place place;
  VisitItemToFavoritEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

/// событие удаления элемента списка из избранного
class VisitItemRemoveFromFavoritEvent extends FavoritListEvent {
  final Place place;
  VisitItemRemoveFromFavoritEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

/// событие перемещения элемента
class FavoritItemMoveEvent extends FavoritListEvent {
  final Place after;
  final Place place;
  FavoritItemMoveEvent(
    this.after, this.place,
  ) : super();

  @override
  List<Object> get props => [place];
}
