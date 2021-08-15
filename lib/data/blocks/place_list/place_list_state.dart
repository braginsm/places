import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class PlaceListState extends Equatable {
  const PlaceListState();

  @override
  List<Object> get props => [];
}

///состояние загрузки данных
class PlaceListLoadingInProgressState extends PlaceListState {
  
}

///состояние загруженных данных
class PlaceListLoadingSuccessState extends PlaceListState {
  final List<Place?> placeList;

  const PlaceListLoadingSuccessState(this.placeList);

  @override
  List<Object> get props => [placeList];
}