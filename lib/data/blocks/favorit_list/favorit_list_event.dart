import 'package:equatable/equatable.dart';

/// базовый эвент списка избранных мест
abstract class FavoritListEvent extends Equatable {
  const FavoritListEvent();

  @override
  List<Object> get props => [];
}

/// событие начала закгрузки избранных мест
class FavoritListLoadEvent extends FavoritListEvent {}

/// событие добавления элемента списка в избранное
class VisitItemToFavoritEvent extends FavoritListEvent {}

/// событие удаления элемента списка из избранного
class VisitItemRemoveFromFavoritEvent extends FavoritListEvent {}