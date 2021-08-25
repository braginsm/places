import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class SearchHistoryEvent extends Equatable {
  const SearchHistoryEvent();

  @override
  List<Object> get props => [];
}

class SearchHistoryLoadingEvent extends SearchHistoryEvent {}

class SearchHistoryDeleteByIdEvent extends SearchHistoryEvent {
  final int id;
  const SearchHistoryDeleteByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchHistoryClearEvent extends SearchHistoryEvent {}

class SearchHistoryAddEvent extends SearchHistoryEvent {
  final Place place;

  const SearchHistoryAddEvent(this.place);

  @override
  List<Object> get props => [place];
}
