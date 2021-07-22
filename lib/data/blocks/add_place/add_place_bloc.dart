import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

import 'add_place_event.dart';
import 'add_place_state.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final PlaceInteractor _placeInteractor;

  AddPlaceBloc(this._placeInteractor) : super(AddPlaceLoadingInProgressState());

  Place _place = Place();

  @override
  Stream<AddPlaceState> mapEventToState(AddPlaceEvent event) async* {
    if (event is AddPlaceLoadEvent) {
      yield* _mapAddPlaceLoadEventToState();
    }

    if (event is AddPlaceClearFormEvent) {
      yield* _mapAddPlaceClearFormEventToState();
    }

    throw UnimplementedError();
  }

  Stream<AddPlaceState> _mapAddPlaceClearFormEventToState() async* {
    yield AddPlaceLoadingSuccessState(_place);
  }

  Stream<AddPlaceState> _mapAddPlaceLoadEventToState() async* {
    yield AddPlaceLoadingSuccessState(_place);
  }
}
