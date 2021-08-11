import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/data/blocks/add_place/add_place_state.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/widgets/add_image_item.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:provider/provider.dart';

import 'select_category.dart';
import 'widgets/preloader.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  AddPlaceBloc _bloc;

  @override
  void initState() {
    _bloc = AddPlaceBloc(context.read<PlaceInteractor>())
      ..add(AddPlaceLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPlaceBloc>(
      create: (context) => _bloc,
      child: BlocBuilder<AddPlaceBloc, AddPlaceState>(
        builder: (context, state) {
          if (state is AddPlaceLoadingInProgressState)
            return PreloaderWidget();
          if (state is AddPlaceErrorState)
            return SmthError();
          if (state is AddPlaceLoadingSuccessState)
            return Scaffold(
              appBar: AppBar(
                leading: TextButton(
                  onPressed: () {
                    state.nameController.clear();
                    state.latController.clear();
                    state.lonController.clear();
                    state.descriptionController.clear();
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
                              itemCount: state.images.length,
                              itemBuilder: (context, index) {
                                final img = state.images[index];
                                return AddImageItem(img: img, bloc: _bloc,);
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
                                  state.placeType == null
                                      ? "Не выбрано"
                                      : Place.ruPlaceTypeNames[state.placeType.index],
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
                                          bloc: _bloc,
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
                              focusNode: state.nameNode,
                              decoration: InputDecoration(
                                hintText: 'название',
                              ),
                              controller: state.nameController,
                              onSubmitted: (value) =>
                                  state.latNode.requestFocus(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 12, 8, 0),
                                        child: TextField(
                                          controller: state.latController,
                                          decoration: InputDecoration(
                                            hintText: 'широта',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.cancel_rounded),
                                              onPressed: () =>
                                                  state.latController.clear(),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          focusNode: state.latNode,
                                          onSubmitted: (value) =>
                                              state.lonNode.requestFocus(),
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
                                            controller: state.lonController,
                                            focusNode: state.lonNode,
                                            onSubmitted: (value) => state
                                                .descriptionNode
                                                .requestFocus(),
                                            decoration: InputDecoration(
                                              hintText: 'долгота',
                                              suffixIcon: IconButton(
                                                icon:
                                                    Icon(Icons.cancel_rounded),
                                                onPressed: () =>
                                                    state.lonController.clear(),
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
                              style: TextStyleSet().textMedium16.copyWith(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "ОПИСАНИЕ",
                              style: TextStyleSet().textRegular.copyWith(
                                  color:
                                      Theme.of(context).unselectedWidgetColor),
                            ),
                          ),
                          TextField(
                            controller: state.descriptionController,
                            focusNode: state.descriptionNode,
                            onSubmitted: (value) =>
                                state.descriptionNode.unfocus(),
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
                        onPressed: () => _bloc.add(AddPlaceSaveEvent(Place(
                          name: state.nameController.text,
                          description: state.descriptionController.text,
                          lat: double.parse(state.latController.text),
                          lon: double.parse(state.lonController.text),
                          placeType: state.placeType,
                          urls: state.images
                        ))),
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
          throw ArgumentError("Неожиданное состояние в _StreamSliverListState");
        },
      ),
    );
  }
}
