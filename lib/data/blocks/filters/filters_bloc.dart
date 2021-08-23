import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/user_property_interactor.dart';

import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final UserPropertyInteractor _userPropertyInteractor;
  FiltersBloc(this._userPropertyInteractor)
      : super(FiltersLoadingInProgressState());

  @override
  Stream<FiltersState> mapEventToState(event) async* {
    if (event is FiltersLoadingEvent) {
      yield* _mapFiltersLoadingEventToState();
    }
    if (event is FiltersRadiusChangeEvent) {
      yield* _mapFiltersRadiusChangeEventToState(event);
    }
    if (event is FiltersCategoryChangeEvent) {
      yield* _mapFiltersCategoryChangeEventToState(event);
    }
    if (event is FiltersCleanEvent) {
      yield* _mapFiltersCleanEventToState(event);
    }
  }

  Stream<FiltersState> _mapFiltersLoadingEventToState() async* {
    yield FiltersLoadingInProgressState();
    final _minRadius = await _userPropertyInteractor.getMinSearchRadius();
    final _maxRadius = await _userPropertyInteractor.getMaxSearchRadius();
    final _categoryFilters = await _userPropertyInteractor.getCategoryFIlters();
    yield FiltersLoadingSuccessState(
        minRadius: _minRadius,
        maxRadius: _maxRadius,
        categorys: _categoryFilters);
  }

  Stream<FiltersState> _mapFiltersRadiusChangeEventToState(
      FiltersRadiusChangeEvent event) async* {
    await _userPropertyInteractor.setMinSearchRadius(event.minRadius);
    await _userPropertyInteractor.setMaxSearchRadius(event.maxRadius);
    add(FiltersLoadingEvent());
  }

  Stream<FiltersState> _mapFiltersCategoryChangeEventToState(
      FiltersCategoryChangeEvent event) async* {
    await _userPropertyInteractor.setCategoryFIlters(event.index, event.value);
    add(FiltersLoadingEvent());
  }

  Stream<FiltersState> _mapFiltersCleanEventToState(
      FiltersCleanEvent event) async* {
    await _userPropertyInteractor.cleanCategoryFIlters();
    await _userPropertyInteractor.setMinSearchRadius(0);
    await _userPropertyInteractor.setMaxSearchRadius(10000);
    add(FiltersLoadingEvent());
  }
}
