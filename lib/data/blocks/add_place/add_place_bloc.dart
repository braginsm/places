import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/NetworkExeption.dart';

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

    throw UnimplementedError();
  }

  Stream<AddPlaceState> _mapAddPlaceDismissedImageToState(String img) async* {
    AddPlaceLoadingSuccessState _state = state;
    _state.images.remove(img);
    yield _state;
  }

  Stream<AddPlaceState> _mapAddPlaceTypeChangeToState(PlaceType type) async* {
    yield AddPlaceLoadingInProgressState();
    AddPlaceLoadingSuccessState _state = state;
    _state.placeType = type;
    yield _state;
  }

  Stream<AddPlaceState> _mapAddPlaceSaveEventToState(Place place) async* {
    yield AddPlaceLoadingInProgressState();
    try {
      await _placeInteractor.addNewPlace(place);
      yield AddPlaceLoadingSuccessState();
    } on NetworkExeption catch (e) {
      yield AddPlaceErrorState();
    }
  }

  Stream<AddPlaceState> _mapAddPlaceClearFormEventToState() async* {
    yield AddPlaceLoadingSuccessState();
  }

  Stream<AddPlaceState> _mapAddPlaceLoadEventToState() async* {
    yield AddPlaceLoadingSuccessState();
  }
}