import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceInteractor _placeInteractor;

  @observable
  ObservableFuture<List<Place>> getPlaceListFuture;

  PlaceListStoreBase(this._placeInteractor);

  @action
  void getPlaceList() {
    final future = _placeInteractor.getPlaces();
    getPlaceListFuture = ObservableFuture(future);
  }

  @action
  void toggleFavorites(Place place) {
    _placeInteractor.toggleFavorites(place);
  }
}
