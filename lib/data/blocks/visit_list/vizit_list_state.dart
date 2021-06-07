import 'package:equatable/equatable.dart';
import 'package:places/data/model/Place.dart';

abstract class VisitListState extends Equatable {
  const VisitListState();

  @override
  List<Object> get props => [];
}

/// состояние загрузки данных
class VisitListLoadingInProgress extends VisitListState {}

/// состояние загруженных данных
class VisitListLoadingSuccess extends VisitListState {
  final List<Place> favoritList;

  VisitListLoadingSuccess(this.favoritList);

  @override
  List<Object> get props => [favoritList];
}
