import 'package:equatable/equatable.dart';

/// базовый эвент списка избранных мест
abstract class VisitListEvent extends Equatable {
  const VisitListEvent();

  @override
  List<Object> get props => [];
}

/// событие начала закгрузки посещенных мест
class VisitListLoadEvent extends VisitListEvent {}

/// событие добавления элемента списка в посещенное
class VisitItemToVisitEvent extends VisitListEvent {}

/// событие удаления элемента списка из посещенных
class VisitItemRemoveFromVisitEvent extends VisitListEvent {}