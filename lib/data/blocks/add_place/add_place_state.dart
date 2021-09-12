import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class AddPlaceState extends Equatable {
  const AddPlaceState();

  @override
  List<Object> get props => [];
}

class AddPlaceLoadingInProgressState extends AddPlaceState {}

class AddPlaceErrorState extends AddPlaceState {}

class AddPlaceLoadingSuccessState extends AddPlaceState {
  final PlaceType placeType;
  final List<String> images;
  final String name;
  final double lat;
  final double lon;
  final String description;

  const AddPlaceLoadingSuccessState(
      {this.name = "",
      this.lat = 0,
      this.lon = 0,
      this.description = "",
      this.placeType = PlaceType.other,
      this.images = const [""]});

  @override
  List<Object> get props => [name, lat, lon, description, images, placeType];

  AddPlaceLoadingSuccessState copiWith(
      {PlaceType? placeType,
      List<String>? images,
      String? name,
      double? lat,
      double? lon,
      String? description}) {
    return AddPlaceLoadingSuccessState(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      description: description ?? this.description,
      images: images ?? this.images,
      placeType: placeType ?? this.placeType,
    );
  }
}
