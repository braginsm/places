import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_visit.dart';

/// базовый эвент списка избранных мест
abstract class VisitListEvent extends Equatable {
  const VisitListEvent();

  @override
  List<Object> get props => [];
}

/// событие начала закгрузки посещенных мест
class VisitListLoadEvent extends VisitListEvent {}

/// событие добавления элемента списка в посещенное
class VisitItemToVisitEvent extends VisitListEvent {
  final PlaceVisit place;
  const VisitItemToVisitEvent(this.place);

  @override
  List<Object> get props => [place];
}

/// событие удаления элемента списка из посещенных
class VisitItemRemoveFromVisitEvent extends VisitListEvent {
  final PlaceVisit place;
  const VisitItemRemoveFromVisitEvent(this.place);

  @override
  List<Object> get props => [place];
}
