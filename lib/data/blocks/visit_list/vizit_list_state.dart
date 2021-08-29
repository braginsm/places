import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_visit.dart';

abstract class VisitListState extends Equatable {
  const VisitListState();

  @override
  List<Object> get props => [];
}

/// состояние загрузки данных
class VisitListLoadingInProgress extends VisitListState {}

/// состояние загруженных посещенных мест
class VisitListLoadingSuccess extends VisitListState {
  final List<PlaceVisit> visitList;

  const VisitListLoadingSuccess(this.visitList);

  @override
  List<Object> get props => [visitList];
}
