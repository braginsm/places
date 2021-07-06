import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/widgets/add_image_item.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:relation/relation.dart';

import 'select_category.dart';
import 'add_place_wm.dart';

class AddPlaceScreen extends CoreMwwmWidget {
  const AddPlaceScreen({WidgetModelBuilder widgetModelBuilder})
      : super(
          widgetModelBuilder:
              widgetModelBuilder ?? AddPlaceScreenWidgetModel.builder,
        );

  _AddPlaceScreenState createState() => _AddPlaceScreenState();

  @override
  WidgetState<CoreMwwmWidget<WidgetModel>, WidgetModel> createWidgetState() {
    throw UnimplementedError();
  }
}

class _AddPlaceScreenState extends WidgetState<
    CoreMwwmWidget<AddPlaceScreenWidgetModel>, AddPlaceScreenWidgetModel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode latNode = FocusNode();
  FocusNode lonNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  void _addPlace() {
    wm.savePlaceAction(Place(
      name: nameController.text,
      lat: double.parse(latController.text),
      lon: double.parse(lonController.text),
      description: descriptionController.text,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<Place>(
        streamedState: wm.formPlaceState,
        errorBuilder: (context, e) => SmthError(),
        builder: (context, place) {
          return Scaffold(
            appBar: AppBar(
              leading: TextButton(
                onPressed: () {
                  nameController.clear();
                  latController.clear();
                  lonController.clear();
                  descriptionController.clear();
                },
                child: Container(
                    child: Text(
                  "Отмена",
                  style: TextStyleSet()
                      .textMedium16
                      .copyWith(color: Theme.of(context).hintColor),
                )),
              ),
              leadingWidth: 90,
              title: Text("Новое место"),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                place.urls.length,
                            itemBuilder: (context, index) {
                              final img = place.urls[index];
                              return AddImageItem(img: img);
                            },
                          ),
                        ),
                        Text(
                          "КАТЕГОРИЯ",
                          style: TextStyleSet().textRegular.copyWith(
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                place.placeType == null
                                    ? "Не выбрано"
                                    : Place.ruPlaceTypeNames[place.placeType.index],
                                style: TextStyleSet().textRegular16.copyWith(
                                    color: Theme.of(context).hintColor),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10,
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SelectPlaceCategory(
                                        formPlaceState: wm.formPlaceState,
                                        editPlaceCategoryAction: wm.editPlaceCategoryAction,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Delimer(),
                        ),
                        Text(
                          "НАЗВАНИЕ",
                          style: TextStyleSet().textRegular.copyWith(
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: TextField(
                            //autofocus: true,
                            focusNode: nameNode,
                            decoration: InputDecoration(
                              hintText: 'название',
                            ),
                            controller: nameController,
                            onSubmitted: (value) => latNode.requestFocus(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ШИРОТА",
                                      style: TextStyleSet()
                                          .textRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .unselectedWidgetColor),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 8, 0),
                                      child: TextField(
                                        controller: latController,
                                        decoration: InputDecoration(
                                          hintText: 'широта',
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.cancel_rounded),
                                            onPressed: () =>
                                                latController.clear(),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        focusNode: latNode,
                                        onSubmitted: (value) =>
                                            lonNode.requestFocus(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ДОЛГОТА",
                                        style: TextStyleSet()
                                            .textRegular
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .unselectedWidgetColor),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12),
                                        child: TextField(
                                          controller: lonController,
                                          focusNode: lonNode,
                                          onSubmitted: (value) =>
                                              descriptionNode.requestFocus(),
                                          decoration: InputDecoration(
                                            hintText: 'долгота',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.cancel_rounded),
                                              onPressed: () =>
                                                  lonController.clear(),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 25),
                          child: Text(
                            "Указать на карте",
                            style: TextStyleSet()
                                .textMedium16
                                .copyWith(color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "ОПИСАНИЕ",
                            style: TextStyleSet().textRegular.copyWith(
                                color: Theme.of(context).unselectedWidgetColor),
                          ),
                        ),
                        TextField(
                          controller: descriptionController,
                          focusNode: descriptionNode,
                          onSubmitted: (value) => descriptionNode.unfocus(),
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "введите текст",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: _addPlace,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "СОЗДАТЬ",
                          style: TextStyleSet()
                              .textBold
                              .copyWith(color: Theme.of(context).canvasColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
