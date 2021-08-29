import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_visit_interactor.dart';
import 'package:places/data/model/place_visit.dart';

import 'visit_list_event.dart';
import 'vizit_list_state.dart';

/// блок экрана списка избанных мест
class VisitListBloc extends Bloc<VisitListEvent, VisitListState> {
  final PlaceVisitInteractor _placeInteractor;

  VisitListBloc(this._placeInteractor) : super(VisitListLoadingInProgress());

  @override
  Stream<VisitListState> mapEventToState(VisitListEvent event) async* {
    if (event is VisitListLoadEvent) {
      yield* _mapVisitListLoadEventToState();
    }

    if (event is VisitItemToVisitEvent) {
      yield* _mapVisitItemToVisitEventToState(event);
    }

    if (event is VisitItemRemoveFromVisitEvent) {
      yield* _mapVisitItemRemoveFromVisitEventToState(event);
    }
  }

  Stream<VisitListState> _mapVisitListLoadEventToState() async* {
    yield VisitListLoadingInProgress();
    final List<PlaceVisit> vizitList = await _placeInteractor.getAll();
    yield VisitListLoadingSuccess(vizitList);
  }

  Stream<VisitListState> _mapVisitItemToVisitEventToState(
      VisitItemToVisitEvent event) async* {
    _placeInteractor.addPlace(event.place);
    add(VisitListLoadEvent());
  }

  Stream<VisitListState> _mapVisitItemRemoveFromVisitEventToState(
      VisitItemRemoveFromVisitEvent event) async* {
    _placeInteractor.removePlace(event.place);
    add(VisitListLoadEvent());
  }
}
