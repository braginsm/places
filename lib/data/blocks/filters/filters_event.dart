import 'package:equatable/equatable.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

/// событие получения текущих значений фильтров
class FiltersLoadingEvent extends FiltersEvent {}

/// событие изменения радиуса
class FiltersRadiusChangeEvent extends FiltersEvent {
  final double minRadius;
  final double maxRadius;

  const FiltersRadiusChangeEvent(this.minRadius, this.maxRadius);

  @override
  List<Object?> get props => [minRadius, maxRadius];
}

/// событие изменение категорий
class FiltersCategoryChangeEvent extends FiltersEvent {
  final int index;
  final bool value;

  const FiltersCategoryChangeEvent(this.index, this.value);

  @override
  List<Object?> get props => [index, value];
}

/// событие очистки фильтров
class FiltersCleanEvent extends FiltersEvent {}
