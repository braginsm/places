import 'package:places/data/model/Place.dart';

abstract class SearchAction {}

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
