import 'package:equatable/equatable.dart';
import 'package:places/data/model/Place.dart';

abstract class SearchPlaceState extends Equatable {
  const SearchPlaceState();

  @override
  List<Object> get props => [];
}

class SearchPlaceLoadingInProgressState extends SearchPlaceState {}

class SearchPlaceEmptyState extends SearchPlaceState {}

class SearchPlaceLoadingSuccessState extends SearchPlaceState {
  final List<Place> result;

  SearchPlaceLoadingSuccessState(this.result);

  @override
  List<Object> get props => [result];
}
