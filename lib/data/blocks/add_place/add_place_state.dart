import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

abstract class AddPlaceState extends Equatable {
  final List<String> images;
  const AddPlaceState({this.images = const [""]});

  @override
  List<Object> get props => [];
}

class AddPlaceLoadingInProgressState extends AddPlaceState {}

class AddPlaceErrorState extends AddPlaceState {}

class AddPlaceLoadingSuccessState extends AddPlaceState {
  final PlaceType? placeType;

  AddPlaceLoadingSuccessState({this.placeType}) : super();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode latNode = FocusNode();
  final FocusNode lonNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();

  @override
  List<Object> get props => [
        nameController,
        latController,
        lonController,
        descriptionController,
        nameNode,
        latNode,
        lonNode,
        descriptionNode,
        images
      ];
}
