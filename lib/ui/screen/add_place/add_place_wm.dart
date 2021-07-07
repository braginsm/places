import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class AddPlaceScreenWidgetModel extends WidgetModel with ChangeNotifier {
  final PlaceInteractor _placeInteractor;
  final formPlaceState = EntityStreamedState<Place>();

  ///моковые данные
  final List<String> _images = [
    "",
    "https://lifeglobe.net/x/entry/6591/1a.jpg",
    "https://www.freezone.net/upload/medialibrary/7e9/7e9ba16fe427b1dfd99e07ea7cc522d2.jpg",
    "https://tur-ray.ru/wp-content/uploads/2017/11/maska-skorbi.jpg"
  ];

  Place place = Place();

  AddPlaceScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._placeInteractor)
      : super(baseDependencies);

  static AddPlaceScreenWidgetModel builder(BuildContext context) {
    final wmDependencies = WidgetModelDependencies();
    return AddPlaceScreenWidgetModel(
      wmDependencies,
      context.read<PlaceInteractor>(),
    );
  }

  @override
  void onLoad() {
    super.onLoad();
    clearPlace();
  }

  void savePlace(Place place) {
    formPlaceState.loading();
    place = place.copyWith(urls: _images);
    subscribeHandleError<Place>(_placeInteractor.addNewPlace(place).asStream(),
        (place) {
      formPlaceState.content(place);
    });
    notifyListeners();
  }

  void editPlace(Place place) {
    this.place = place;
    formPlaceState.content(place);
    notifyListeners();
  }

  void clearPlace() {
    place = Place(urls: _images);
    formPlaceState.content(Place(urls: _images));
    notifyListeners();
  }
}
