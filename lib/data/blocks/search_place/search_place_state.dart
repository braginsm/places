import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_dto.dart';

abstract class SearchPlaceState extends Equatable {
  const SearchPlaceState();

  @override
  List<Object> get props => [];
}

class SearchPlaceLoadingInProgressState extends SearchPlaceState {}

class SearchPlaceEmptyState extends SearchPlaceState {}

class SearchPlaceLoadingSuccessState extends SearchPlaceState {
  final List<PlaceDto> result;

  const SearchPlaceLoadingSuccessState(this.result);

  @override
  List<Object> get props => [result];
}
