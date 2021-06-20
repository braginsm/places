import 'package:places/data/model/Place.dart';

abstract class SearchAction {}

/// первое открытие поиска
class InitSearch extends SearchAction {}

/// загрузка результатов поиска
class LoadSearch extends SearchAction {
  final String name;

  LoadSearch(this.name);
}

/// Результат загрузки
class ResultSearch extends SearchAction {
  final List<Place> placeList;

  ResultSearch(this.placeList);
}
