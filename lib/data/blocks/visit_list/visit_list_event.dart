import 'package:equatable/equatable.dart';

/// базовый эвент списка избранных мест
abstract class VisitListEvent extends Equatable {
  const VisitListEvent();

  @override
  List<Object> get props => [];
}

/// событие начала закгрузки посещенных мест
class VisitListLoad extends VisitListEvent {}
