import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

import 'favorit_list_event.dart';
import 'favorit_list_state.dart';

/// блок экрана списка избанных мест
class VisitListBlock extends Bloc<FavoritListEvent, FavoritListState> {
  final PlaceInteractor _placeInteractor;
  final Place place;

  VisitListBlock(this._placeInteractor, {this.place})
      : super(FavoritListLoadingInProgress());

  @override
  Stream<FavoritListState> mapEventToState(FavoritListEvent event) async* {
    if (event is FavoritListLoadEvent) {
      yield* _mapFavoritListLoadEventToState();
    }

    if (event is VisitItemToFavoritEvent) {
      yield* _mapVisitItemToFavoritEventToState();
    }

    if (event is VisitItemRemoveFromFavoritEvent) {
      yield* _mapVisitItemRemoveFromFavoritEventToState();
    }
  }

  Stream<FavoritListState> _mapFavoritListLoadEventToState() async* {
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield FavoritListLoadingSuccess(favoritList);
  }

  Stream<FavoritListState> _mapVisitItemToFavoritEventToState() async* {
    if (place != null) _placeInteractor.addToFavorites(place);
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield FavoritListLoadingSuccess(favoritList);
  }

  Stream<FavoritListState> _mapVisitItemRemoveFromFavoritEventToState() async* {
    if (place != null) _placeInteractor.removeFromFavorites(place);
    final List<Place> favoritList = _placeInteractor.getFavoritesPlaces();
    yield FavoritListLoadingSuccess(favoritList);
  }
}
