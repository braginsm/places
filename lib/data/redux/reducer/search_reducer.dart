import 'package:places/data/redux/action/search_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/search_state.dart';

AppState loadSearchReducer(AppState state, LoadSearch action) {
  return AppState(searchState: SearchLoadingState(action.name));
}

AppState resultSearchReducer(AppState state, ResultSearch action) {
  return AppState(searchState: SearchDataState(action.placeList));
}
