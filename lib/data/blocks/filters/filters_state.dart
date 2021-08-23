import 'package:equatable/equatable.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object?> get props => [];
}

/// состояние получения сохраненных фильтров
class FiltersLoadingInProgressState extends FiltersState {}

/// состояние отображения формы фильтров
class FiltersLoadingSuccessState extends FiltersState {
  final double minRadius;
  final double maxRadius;
  final List<bool> categorys;

  const FiltersLoadingSuccessState({
    required this.minRadius, 
    required this.maxRadius, 
    required this.categorys
  });

  @override
  List<Object?> get props => [minRadius, maxRadius, categorys];
}
