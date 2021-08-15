import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

abstract class AddPlaceState extends Equatable {
  const AddPlaceState();

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

  final List<String> images = [
    "",
    "https://lifeglobe.net/x/entry/6591/1a.jpg",
    "https://www.freezone.net/upload/medialibrary/7e9/7e9ba16fe427b1dfd99e07ea7cc522d2.jpg",
    "https://tur-ray.ru/wp-content/uploads/2017/11/maska-skorbi.jpg"
  ];

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
