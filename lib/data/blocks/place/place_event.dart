import 'package:equatable/equatable.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object?> get props => [];
}

/// Событие инициализации загрузки
class PlaceLoadingEvent extends PlaceEvent {
  final int id;
  const PlaceLoadingEvent(this.id);

  @override
  List<Object?> get props => [id];
}
