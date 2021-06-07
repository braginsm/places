import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

import 'visit_list_event.dart';
import 'vizit_list_state.dart';

/// блок экрана списка избанных мест
class VisitListBlock extends Bloc<VisitListEvent, VisitListState> {
  final PlaceInteractor _placeInteractor;

  VisitListBlock(this._placeInteractor) : super(VisitListLoadingInProgress());

  @override
  Stream<VisitListState> mapEventToState(VisitListEvent event) async* {
    if (event is VisitListLoad) {
      yield* _mapVisitListLoadToState();
    }
  }

  Stream<VisitListState> _mapVisitListLoadToState() async* {
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield VisitListLoadingSuccess(favoritList);
  }
}
