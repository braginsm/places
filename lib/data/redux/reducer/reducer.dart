import 'package:places/data/redux/action/search_action.dart';
import 'package:places/data/redux/reducer/search_reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, LoadSearch>(loadSearchReducer),
  TypedReducer<AppState, ResultSearch>(resultSearchReducer),
]);
