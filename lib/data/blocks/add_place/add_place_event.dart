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

class AddPlaceSaveEvent extends AddPlaceEvent {
  final Place place;

  AddPlaceSaveEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

class AddPlaceTypeChangeEvent extends AddPlaceEvent {
  final PlaceType type;

  AddPlaceTypeChangeEvent(this.type) : super();

  @override
  List<Object> get props => [type];
}

class AddPlaceClearFormEvent extends AddPlaceEvent {}

class AddPlaceDismissedImageEvent extends AddPlaceEvent {
  final String img;
  AddPlaceDismissedImageEvent(this.img) : super();

  @override
  List<Object> get props => [img];
}
