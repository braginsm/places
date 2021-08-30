import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/search_history_interactor.dart';

import 'search_history_event.dart';
import 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final SearchHistoryInteractor _searchHistoryInteractor;

  SearchHistoryBloc(this._searchHistoryInteractor)
      : super(SearchHistoryLoadingInProgressState());

  @override
  Stream<SearchHistoryState> mapEventToState(SearchHistoryEvent event) async* {
    if (event is SearchHistoryLoadingEvent) {
      yield* _mapSearchHistoryLoadingEventToState();
    }

    if (event is SearchHistoryAddEvent) {
      yield* _mapSearchHistoryAddEventToState(event);
    }

    if (event is SearchHistoryDeleteByIdEvent) {
      yield* _mapSearchHistoryDeleteByIdEventToState(event);
    }

    if (event is SearchHistoryClearEvent) {
      yield* _mapSearchHistoryClearEventToState(event);
    }
  }

  Stream<SearchHistoryState> _mapSearchHistoryLoadingEventToState() async* {
    final list = await _searchHistoryInteractor.allSearchRequestEntries;
    yield SearchHistoryLoadingSuccessState(list);
  }

  Stream<SearchHistoryState> _mapSearchHistoryAddEventToState(
      SearchHistoryAddEvent event) async* {
    await _searchHistoryInteractor.saveSearchRequest(event.place);
    add(SearchHistoryLoadingEvent());
  }

  Stream<SearchHistoryState> _mapSearchHistoryDeleteByIdEventToState(
      SearchHistoryDeleteByIdEvent event) async* {
    await _searchHistoryInteractor.deleteSearchRequest(event.id);
    add(SearchHistoryLoadingEvent());
  }

  Stream<SearchHistoryState> _mapSearchHistoryClearEventToState(
      SearchHistoryClearEvent event) async* {
    await _searchHistoryInteractor.clearSearchHistory();
    add(SearchHistoryLoadingEvent());
  }
}
