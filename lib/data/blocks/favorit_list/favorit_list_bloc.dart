import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';

import 'favorit_list_event.dart';
import 'favorit_list_state.dart';

/// блок экрана списка избанных мест
class FavoritListBloc extends Bloc<FavoritListEvent, FavoritListState> {
  final PlaceInteractor _placeInteractor;

  FavoritListBloc(this._placeInteractor)
      : super(FavoritListLoadingInProgress());

  @override
  Stream<FavoritListState> mapEventToState(FavoritListEvent event) async* {
    if (event is FavoritListLoadEvent) {
      yield* _mapFavoritListLoadEventToState();
    }

    if (event is VisitItemToFavoritEvent) {
      yield* _mapVisitItemToFavoritEventToState(event);
    }

    if (event is VisitItemRemoveFromFavoritEvent) {
      yield* _mapVisitItemRemoveFromFavoritEventToState(event);
    }

    if (event is FavoritItemMoveEvent) {
      yield* _mapFavoritItemMoveEventToState(event);
    }
  }

  Stream<FavoritListState> _mapFavoritListLoadEventToState() async* {
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }

  Stream<FavoritListState> _mapVisitItemToFavoritEventToState(
      VisitItemToFavoritEvent event) async* {
    _placeInteractor.addToFavorites(event.place);
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }

  Stream<FavoritListState> _mapVisitItemRemoveFromFavoritEventToState(
      VisitItemRemoveFromFavoritEvent event) async* {
    _placeInteractor.removeFromFavorites(event.place);
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }

  Stream<FavoritListState> _mapFavoritItemMoveEventToState(
      FavoritItemMoveEvent event) async* {
    _placeInteractor.moveFavorites(event.after, event.place);
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }
}
