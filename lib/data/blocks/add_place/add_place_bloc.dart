import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/network_exeption.dart';

import 'add_place_event.dart';
import 'add_place_state.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final PlaceInteractor _placeInteractor;

  AddPlaceBloc(this._placeInteractor) : super(AddPlaceLoadingInProgressState());

  @override
  Stream<AddPlaceState> mapEventToState(AddPlaceEvent event) async* {
    if (event is AddPlaceLoadEvent) {
      yield* _mapAddPlaceLoadEventToState();
    }

    if (event is AddPlaceClearFormEvent) {
      yield* _mapAddPlaceClearFormEventToState();
    }

    if (event is AddPlaceSaveEvent) {
      yield* _mapAddPlaceSaveEventToState(event.place);
    }

    if (event is AddPlaceTypeChangeEvent) {
      yield* _mapAddPlaceTypeChangeToState(event.type);
    }

    if (event is AddPlaceDismissedImageEvent) {
      yield* _mapAddPlaceDismissedImageToState(event.img);
    }

    if (event is AddPlaceAddImageEvent) {
      yield* _mapAddPlaceAddImageEventToState(event);
    }

    if (event is AddPlaceSetGeoEvent) {
      yield* _mapAddPlaceSetGeoEventToState(event);
    }
  }

  AddPlaceLoadingSuccessState get _state =>
      state as AddPlaceLoadingSuccessState;

  Stream<AddPlaceState> _mapAddPlaceDismissedImageToState(String? img) async* {
    var _list = _state.images;
    _list.remove(img);
    yield _state.copiWith(images: _list);
  }

  Stream<AddPlaceState> _mapAddPlaceTypeChangeToState(PlaceType type) async* {
    yield _state.copiWith(placeType: type);
  }

  Stream<AddPlaceState> _mapAddPlaceSaveEventToState(Place place) async* {
    yield AddPlaceLoadingInProgressState();
    try {
      await _placeInteractor.addNewPlace(place);
      yield AddPlaceLoadingSuccessState();
    } on NetworkExeption catch (_) {
      yield AddPlaceErrorState();
    }
  }

  Stream<AddPlaceState> _mapAddPlaceClearFormEventToState() async* {
    yield _state.copiWith(name: "", lat: 0, lon: 0, description: "");
  }

  Stream<AddPlaceState> _mapAddPlaceLoadEventToState() async* {
    yield AddPlaceLoadingSuccessState();
  }

  Stream<AddPlaceState> _mapAddPlaceAddImageEventToState(
      AddPlaceAddImageEvent event) async* {
    yield _state.copiWith(images: event.images);
  }

  Stream<AddPlaceState> _mapAddPlaceSetGeoEventToState(
      AddPlaceSetGeoEvent event) async* {
    yield _state.copiWith(lat: event.geo.latitude, lon: event.geo.longitude);
  }
}
