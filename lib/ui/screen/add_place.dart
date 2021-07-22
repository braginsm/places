import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/data/blocks/add_place/add_place_state.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/NetworkExeption.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/widgets/add_image_item.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:provider/provider.dart';

import 'select_category.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // void _addPlace() {
  //   try {
  //     context.read<PlaceInteractor>().addNewPlace(Place(
  //           name: nameController.text,
  //           lat: double.parse(latController.text),
  //           lon: double.parse(lonController.text),
  //           description: descriptionController.text,
  //         ));
  //     Navigator.pop(context);
  //   } on NetworkExeption catch (e) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
  //       return SmthError();
  //     }));
  //   }
  // }

  AddPlaceBloc _bloc;

  @override
  void initState() {
    _bloc = AddPlaceBloc(context.read<PlaceInteractor>())
      ..add(AddPlaceLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<AddPlaceBloc, AddPlaceState>(
        builder: (context, state) {
          if (state is AddPlaceLoadingInProgressState)
            return CircularProgressIndicator();
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
                              itemCount:
                                  context.watch<AddSightState>().images.length,
                              itemBuilder: (context, index) {
                                final img = context
                                    .watch<AddSightState>()
                                    .images[index];
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
                                  context.watch<AddSightState>().type == null
                                      ? "Не выбрано"
                                      : Place.ruPlaceTypeNames[context
                                          .watch<AddSightState>()
                                          .type
                                          .index],
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
                                        builder: (_) => SelectPlaceCategory(),
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
                        onPressed: () {},
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

class AddSightState with ChangeNotifier {
  ///Моковые данные картинок
  List<String> _images = [
    "",
    "https://lifeglobe.net/x/entry/6591/1a.jpg",
    "https://www.freezone.net/upload/medialibrary/7e9/7e9ba16fe427b1dfd99e07ea7cc522d2.jpg",
    "https://tur-ray.ru/wp-content/uploads/2017/11/maska-skorbi.jpg"
  ];

  List<String> get images => _images;

  void removeImage(img) {
    images.remove(img);
    notifyListeners();
  }

  PlaceType _type;

  PlaceType get type => _type;

  void setType(int index) {
    _type = PlaceType.values[index];
    notifyListeners();
  }
}
