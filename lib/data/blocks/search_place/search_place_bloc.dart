import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/search_place/search_place_event.dart';
import 'package:places/data/blocks/search_place/search_place_state.dart';
import 'package:places/data/interactor/SearchInteractor.dart';
import 'package:places/data/model/PlaceDto.dart';

class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  final SerachInteractor _interactor;
  SearchPlaceBloc(this._interactor) : super(SearchPlaceLoadingSuccessState([]));

  @override
  Stream<SearchPlaceState> mapEventToState(SearchPlaceEvent event) async* {
    if (event is SearchPlaceShowEvent) yield* _mapSearchPlaceShowEventToState();

    if (event is SearchPlacePrintQueryEvent)
      yield* _mapSearchPlacePrintQueryToState(event.query);
  }

  Stream<SearchPlaceState> _mapSearchPlacePrintQueryToState(
      String query) async* {
    final List<PlaceDto> result =
        query.isNotEmpty ? await _interactor.searchPlacesByName(query) : [];
    yield result.isNotEmpty ? SearchPlaceLoadingSuccessState(result) : SearchPlaceEmptyState();
  }

  Stream<SearchPlaceState> _mapSearchPlaceShowEventToState() async* {
    yield SearchPlaceLoadingSuccessState([]);
  }
}
