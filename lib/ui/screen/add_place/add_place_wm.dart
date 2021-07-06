import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class AddPlaceScreenWidgetModel extends WidgetModel {
  final PlaceInteractor _placeInteractor;
  final formPlaceState = EntityStreamedState<Place>();

  final clearFormAction = VoidAction();
  final editPlaceAction = StreamedAction<Place>();
  final savePlaceAction = StreamedAction<Place>();
  final editPlaceCategoryAction = StreamedAction<int>();

  ///моковые данные
  final List<String> _images = [
    "",
    "https://lifeglobe.net/x/entry/6591/1a.jpg",
    "https://www.freezone.net/upload/medialibrary/7e9/7e9ba16fe427b1dfd99e07ea7cc522d2.jpg",
    "https://tur-ray.ru/wp-content/uploads/2017/11/maska-skorbi.jpg"
  ];

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
  void onBind() {
    super.onBind();

    subscribe(clearFormAction.stream, (value) {
      _clearPlace();
    });

    subscribe<Place>(editPlaceAction.stream, (place) {
      _editPlace(place);
    });

    subscribe<Place>(savePlaceAction.stream, (place) {
      _savePlace(place.copyWith(urls: _images));
    });

    subscribe<int>(editPlaceCategoryAction.stream, (value) {
      _editPlace(formPlaceState.value.data
          .copyWith(placeType: PlaceType.values[value]));
    });
  }

  @override
  void onLoad() {
    super.onLoad();
    if (formPlaceState.value.hasError) {
      _clearPlace();
    } 
  }

  void _savePlace(Place place) {
    formPlaceState.loading();
    subscribeHandleError<Place>(_placeInteractor.addNewPlace(place).asStream(),
        (place) {
      formPlaceState.content(place);
    });
  }

  void _editPlace(Place place) {
    formPlaceState.content(place);
  }

  void _clearPlace() {
    formPlaceState.content(Place(urls: _images));
  }
}
