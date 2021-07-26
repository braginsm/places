import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/Place.dart';

abstract class AddPlaceState extends Equatable {
  const AddPlaceState();

  @override
  List<Object> get props => [];
}

class AddPlaceLoadingInProgressState extends AddPlaceState {}

class AddPlaceLoadingSuccessState extends AddPlaceState {
  AddPlaceLoadingSuccessState();
    TextEditingController nameController = TextEditingController();
    TextEditingController latController = TextEditingController();
    TextEditingController lonController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    FocusNode nameNode = FocusNode();
    FocusNode latNode = FocusNode();
    FocusNode lonNode = FocusNode();
    FocusNode descriptionNode = FocusNode();

  @override
  List<Object> get props => [
        nameController,
        latController,
        lonController,
        descriptionController,
        nameNode,
        latNode,
        lonNode,
        descriptionNode
      ];
}
