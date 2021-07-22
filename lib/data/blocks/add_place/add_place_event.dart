import 'package:equatable/equatable.dart';
import 'package:places/data/model/Place.dart';

abstract class AddPlaceEvent extends Equatable {
  const AddPlaceEvent();

  @override
  List<Object> get props => [];
}

class AddPlaceLoadEvent extends AddPlaceEvent {}

class AddPlaceChangeEvent extends AddPlaceEvent {
  final Place place;

  AddPlaceChangeEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

class AddPlaceSaveEvent extends AddPlaceEvent {}

class AddPlaceClearFormEvent extends AddPlaceEvent {}
