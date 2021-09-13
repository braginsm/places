import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';

import 'place_list_event.dart';
import 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _interactor;
  PlaceListLoadingSuccessState _state = const PlaceListLoadingSuccessState([]);

  PlaceListBloc(this._interactor) : super(PlaceListLoadingInProgressState()) {
    stream.listen((event) {
      if (event is PlaceListLoadingSuccessState) _state = event;
    });
  }

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) async* {
    if (event is PlaceListLoadEvent) {
      yield* _mapPlaceListLoadEventToState();
    }

    if (event is PlaceListMapTapEvent) {
      yield* _mapPlaceListMapTapEventToState(event);
    }
  }

  Stream<PlaceListState> _mapPlaceListLoadEventToState() async* {
    final placeList = await _interactor.getPlaces();
    yield PlaceListLoadingSuccessState(placeList);
  }

  Stream<PlaceListState> _mapPlaceListMapTapEventToState(
      PlaceListMapTapEvent event) async* {
    if (_state.placeList.isEmpty) return;
    final list = _state.placeList;
    list.sort((a, b) =>
        a.getDistans(event.point).compareTo(b.getDistans(event.point)));
    final place = list.first;
    if (place.getDistans(event.point) <= 300) {
      yield PlaceListShowPlaceOnMapState.fromParent(place, _state);
    } else {
      yield _state;
    }
  }
}
