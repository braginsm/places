import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/place/place_event.dart';
import 'package:places/data/blocks/place/place_state.dart';
import 'package:places/data/interactor/place_interactor.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceInteractor _placeInteractor;

  PlaceBloc(this._placeInteractor) : super(PlaceLoadingInProgressState());

  @override
  Stream<PlaceState> mapEventToState(PlaceEvent event) async* {
    if (event is PlaceLoadingEvent) {
      yield* _mapPlaceLoadingEventToState(event);
    }
  }

  Stream<PlaceState> _mapPlaceLoadingEventToState(
      PlaceLoadingEvent event) async* {
    yield PlaceLoadingInProgressState();
    try {
      final place = await _placeInteractor.getPlaceDetails(event.id);
      yield PlaceShowState(place);
    } catch (e) {
      rethrow;
    }
  }
}
