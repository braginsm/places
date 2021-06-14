import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

import 'visit_list_event.dart';
import 'vizit_list_state.dart';

/// блок экрана списка избанных мест
class VisitListBloc extends Bloc<VisitListEvent, VisitListState> {
  final PlaceInteractor _placeInteractor;
  final Place place;

  VisitListBloc(this._placeInteractor, {this.place})
      : super(VisitListLoadingInProgress());

  @override
  Stream<VisitListState> mapEventToState(VisitListEvent event) async* {
    if (event is VisitListLoadEvent) {
      yield* _mapVisitListLoadEventToState();
    }

    if (event is VisitItemToVisitEvent) {
      yield* _mapVisitItemToVisitEventToState();
    }

    if (event is VisitItemRemoveFromVisitEvent) {
      yield* _mapVisitItemRemoveFromVisitEventToState();
    }
  }

  Stream<VisitListState> _mapVisitListLoadEventToState() async* {
    final List<Place> vizitList = _placeInteractor.getVisitPlaces();
    yield VisitListLoadingSuccess(vizitList);
  }

  Stream<VisitListState> _mapVisitItemToVisitEventToState() async* {
    if (place != null) _placeInteractor.addToVisitingPlaces(place);
    final List<Place> vizitList = _placeInteractor.getVisitPlaces();
    yield VisitListLoadingSuccess(vizitList);
  }

  Stream<VisitListState> _mapVisitItemRemoveFromVisitEventToState() async* {
    if (place != null) _placeInteractor.removeFromFavorites(place);
    final List<Place> vizitList = _placeInteractor.getVisitPlaces();
    yield VisitListLoadingSuccess(vizitList);
  }
}
