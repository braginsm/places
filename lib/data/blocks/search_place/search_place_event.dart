import 'package:equatable/equatable.dart';

abstract class SearchPlaceEvent extends Equatable {
  const SearchPlaceEvent();

  @override
  List<Object> get props => [];
}

///Показ виджета поиска
class SearchPlaceShowEvent extends SearchPlaceEvent {}

///событие изменения поля ввода поискового запроса
class SearchPlacePrintQueryEvent extends SearchPlaceEvent {
  final String query;

  SearchPlacePrintQueryEvent(this.query);
  @override
  List<Object> get props => [query];
}
