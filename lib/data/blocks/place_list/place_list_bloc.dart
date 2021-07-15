import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';

import 'place_list_event.dart';
import 'place_list_state.dart';

class PlaceListBlock extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceInteractor _interactor;

  PlaceListBlock(this._interactor) : super(PlaceListLoadingInProgressState());

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) {
    if (event is PlaceListLoadEvent) {
      yield* _mapPlaceListLoadEventToState();
    }
    throw UnimplementedError();
  }

  Stream<PlaceListState> _mapPlaceListLoadEventToState() async* {
    final placeList = await _interactor.getPlaces();
    yield PlaceListLoadingSuccessState(placeList);
  }
}
