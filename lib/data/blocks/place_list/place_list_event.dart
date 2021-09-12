import 'package:equatable/equatable.dart';
import 'package:places/data/model/geo.dart';

abstract class PlaceListEvent extends Equatable {
  const PlaceListEvent();

  @override
  List<Object> get props => [];
}

///событие начала загрузки списка мест
class PlaceListLoadEvent extends PlaceListEvent {}

class PlaceListMapTapEvent extends PlaceListEvent {
  final Geo point;

  const PlaceListMapTapEvent(this.point);
  @override
  List<Object> get props => [point];
}
