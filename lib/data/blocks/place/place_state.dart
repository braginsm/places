import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object?> get props => [];
}

/// Состояние загрузки
class PlaceLoadingInProgressState extends PlaceState {}

/// Состояние отображения данных
class PlaceShowState extends PlaceState{
  final Place place;

  const PlaceShowState(this.place);

  @override
  List<Object?> get props => [place];
}
