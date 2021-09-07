import 'package:equatable/equatable.dart';
import 'package:places/data/model/geo.dart';
import 'package:places/data/model/place.dart';

abstract class AddPlaceEvent extends Equatable {
  const AddPlaceEvent();

  @override
  List<Object?> get props => [];
}

class AddPlaceLoadEvent extends AddPlaceEvent {}

class AddPlaceChangeEvent extends AddPlaceEvent {
  final Place place;

  const AddPlaceChangeEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

class AddPlaceSaveEvent extends AddPlaceEvent {
  final Place place;

  const AddPlaceSaveEvent(this.place) : super();

  @override
  List<Object> get props => [place];
}

class AddPlaceTypeChangeEvent extends AddPlaceEvent {
  final PlaceType type;

  const AddPlaceTypeChangeEvent(this.type) : super();

  @override
  List<Object> get props => [type];
}

class AddPlaceClearFormEvent extends AddPlaceEvent {}

class AddPlaceDismissedImageEvent extends AddPlaceEvent {
  final String? img;
  const AddPlaceDismissedImageEvent(this.img) : super();

  @override
  List<Object?> get props => [img];
}

class AddPlaceAddImageEvent extends AddPlaceEvent {
  final List<String> images;
  const AddPlaceAddImageEvent(this.images) : super();

  @override
  List<Object?> get props => [images];
}

class AddPlaceSetGeoEvent extends AddPlaceEvent {
  final Geo geo;

  const AddPlaceSetGeoEvent(this.geo);
  @override
  List<Object?> get props => [geo];
}
