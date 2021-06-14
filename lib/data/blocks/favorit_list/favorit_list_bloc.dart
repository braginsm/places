import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

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
      yield* _mapVisitItemToFavoritEventToState(event.place);
    }

    if (event is VisitItemRemoveFromFavoritEvent) {
      yield* _mapVisitItemRemoveFromFavoritEventToState(event.place);
    }
  }

  Stream<FavoritListState> _mapFavoritListLoadEventToState() async* {
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }

  Stream<FavoritListState> _mapVisitItemToFavoritEventToState(
      Place place) async* {
    _placeInteractor.addToFavorites(place);
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }

  Stream<FavoritListState> _mapVisitItemRemoveFromFavoritEventToState(
      Place place) async* {
    _placeInteractor.removeFromFavorites(place);
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(_placeInteractor.getFavoritesPlaces());
  }
}
