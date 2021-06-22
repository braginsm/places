import 'package:places/data/model/PlaceDto.dart';

abstract class SearchState {}

///состояние инициализации
class SearchInitialState extends SearchState {}

///состояние процесса загрузки
class SearchLoadingState extends SearchState {
  final String name;

  SearchLoadingState(this.name);
}

///состояние отображения результата
class SearchDataState extends SearchState {
  final List<PlaceDto> placeLIst;

  SearchDataState(this.placeLIst);
}
