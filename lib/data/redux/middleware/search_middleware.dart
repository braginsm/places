import 'package:places/data/interactor/SearchInteractor.dart';
import 'package:places/data/redux/action/search_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<AppState> {
  final SerachInteractor _serachInteractor;

  SearchMiddleware(this._serachInteractor);

  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSearch) {
      var result = await _serachInteractor.searchPlacesByName(action.name);
      store.dispatch(ResultSearch(result));
    }
    throw UnimplementedError();
  }
}
