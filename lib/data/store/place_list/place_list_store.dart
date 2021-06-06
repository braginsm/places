import 'package:mobx/mobx.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/PlaceRepository.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceRepository _placeRepository;

  @observable
  ObservableFuture<List<Place>> getPlaceListFuture;

  PlaceListStoreBase(this._placeRepository);

  @action
  void getPlaceList() {
    final future = _placeRepository.getByParameters(count: 10);
    getPlaceListFuture = ObservableFuture(future);
  }
}
