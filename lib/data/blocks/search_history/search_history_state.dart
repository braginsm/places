import 'package:equatable/equatable.dart';
import 'package:places/database/database.dart';

abstract class SearchHistoryState extends Equatable {
  const SearchHistoryState();

  @override
  List<Object?> get props => [];
}

class SearchHistoryLoadingInProgressState extends SearchHistoryState {}

class SearchHistoryLoadingSuccessState extends SearchHistoryState {
  final List<SearchRequest> list;

  const SearchHistoryLoadingSuccessState(this.list);

  @override
  List<Object?> get props => [list];
}
