import 'package:equatable/equatable.dart';

abstract class PlaceListEvent extends Equatable {
  const PlaceListEvent();

  @override
  List<Object> get props => [];
}

///событие начала загрузки списка мест
class PlaceListLoadEvent extends PlaceListEvent {}
