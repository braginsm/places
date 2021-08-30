import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_favorit_interactor.dart';

import 'favorit_list_event.dart';
import 'favorit_list_state.dart';

/// блок экрана списка избанных мест
class FavoritListBloc extends Bloc<FavoritListEvent, FavoritListState> {
  final PlaceFavoritInteractor _placeInteractor;

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
    yield FavoritListLoadingInProgress();
    yield FavoritListLoadingSuccess(await _placeInteractor.getAll());
  }

  Stream<FavoritListState> _mapVisitItemToFavoritEventToState(
      VisitItemToFavoritEvent event) async* {
    _placeInteractor.addPlace(event.place);
    add(FavoritListLoadEvent());
  }

  Stream<FavoritListState> _mapVisitItemRemoveFromFavoritEventToState(
      VisitItemRemoveFromFavoritEvent event) async* {
    _placeInteractor.removePlace(event.place);
    add(FavoritListLoadEvent());
  }

  Stream<FavoritListState> _mapFavoritItemMoveEventToState(
      FavoritItemMoveEvent event) async* {
    _placeInteractor.move(event.after, event.place);
    add(FavoritListLoadEvent());
  }
}
