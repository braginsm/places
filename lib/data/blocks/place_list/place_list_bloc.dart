import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';

import 'place_list_event.dart';
import 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _interactor;

  PlaceListBloc(this._interactor) : super(PlaceListLoadingInProgressState());

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) async* {
    if (event is PlaceListLoadEvent) {
      yield* _mapPlaceListLoadEventToState();
    }
  }

  Stream<PlaceListState> _mapPlaceListLoadEventToState() async* {
    final placeList = await _interactor.getPlaces();
    yield PlaceListLoadingSuccessState(placeList);
  }
}
