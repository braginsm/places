import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

import 'visit_list_event.dart';
import 'vizit_list_state.dart';

/// блок экрана списка избанных мест
class VisitListBlock extends Bloc<VisitListEvent, VisitListState> {
  final PlaceInteractor _placeInteractor;
  final Place place;

  VisitListBlock(this._placeInteractor, {this.place})
      : super(VisitListLoadingInProgress());

  @override
  Stream<VisitListState> mapEventToState(VisitListEvent event) async* {
    if (event is VisitListLoadEvent) {
      yield* _mapVisitListLoadToState();
    }
    if (event is FavoritListLoadEvent) {
      yield* _mapFavoritListLoadToState();
    }
    if (event is VisitItemToFavoritEvent) {
      yield* _mapVisitItemToFavoritToState();
    }
  }

  Stream<VisitListState> _mapVisitListLoadToState() async* {
    final List<Place> favoritList = _placeInteractor.getVisitPlaces();
    yield VisitListLoadingSuccess(favoritList);
  }

  Stream<VisitListState> _mapFavoritListLoadToState() async* {
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield FavoritListLoadingSuccess(favoritList);
  }

  Stream<VisitListState> _mapVisitItemToFavoritToState() async* {
    _placeInteractor.addToFavorites(place);
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield FavoritListLoadingSuccess(favoritList);
  }
}
