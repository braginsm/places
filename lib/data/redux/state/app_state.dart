import 'package:places/data/redux/state/search_state.dart';

class AppState {
  final SearchState searchState;

  AppState({SearchState searchState})
      : this.searchState = searchState ?? SearchInitialState();
}
