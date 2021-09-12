import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/data/blocks/add_place/add_place_state.dart';
import 'package:places/data/interactor/geo_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/map.dart';
import 'package:places/ui/screen/smth_error.dart';
import 'package:places/ui/screen/widgets/add_image_item.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:provider/provider.dart';

import 'select_category.dart';
import 'widgets/preloader.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  late AddPlaceBloc _bloc;

  @override
  void initState() {
    _bloc = AddPlaceBloc(context.read<PlaceInteractor>())
      ..add(AddPlaceLoadEvent());
    _setCurentGeo();
    super.initState();
  }

  Future<void> _setCurentGeo() async {
    final currentGeo = await context.read<GeoInteractor>().currentPosition;
    _bloc.add(AddPlaceSetGeoEvent(currentGeo));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPlaceBloc>(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () => _bloc.add(AddPlaceClearFormEvent()),
            child: Text(
              "Отмена",
              style: TextStyleSet()
                  .textMedium16
                  .copyWith(color: Theme.of(context).hintColor),
            ),
          ),
          leadingWidth: 90,
          title: const Text("Новое место"),
        ),
        body: BlocBuilder<AddPlaceBloc, AddPlaceState>(
          builder: (context, state) {
            if (state is AddPlaceLoadingInProgressState) {
              return const PreloaderWidget();
            }
            if (state is AddPlaceErrorState) {
              return const SmthError();
            }
            if (state is AddPlaceLoadingSuccessState) {
              return AddPlaceFormWidget(
                bloc: _bloc,
                name: state.name,
                description: state.description,
                lat: state.lat,
                lon: state.lon,
                placeType: state.placeType,
                images: state.images,
              );
            }
            throw ArgumentError(
                "Неожиданное состояние в _StreamSliverListState");
          },
        ),
      ),
    );
  }
}

class AddPlaceFormWidget extends StatefulWidget {
  final String name;
  final String description;
  final double lat;
  final double lon;
  final List<String> images;
  final AddPlaceBloc bloc;
  final PlaceType placeType;
  const AddPlaceFormWidget(
      {Key? key,
      this.name = "",
      this.description = "",
      this.lat = 0,
      this.lon = 0,
      this.images = const [""],
      this.placeType = PlaceType.other,
      required this.bloc})
      : super(key: key);

  @override
  _AddPlaceFormWidgetState createState() => _AddPlaceFormWidgetState();
}

class _AddPlaceFormWidgetState extends State<AddPlaceFormWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode latNode = FocusNode();
  final FocusNode lonNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();

  Place get _currentPlace => Place(
    name: nameController.text,
    description: descriptionController.text,
    lat: double.parse(latController.text.isNotEmpty ? latController.text : "0"),
    lon: double.parse(lonController.text.isNotEmpty ? lonController.text : "0"),
    placeType: widget.placeType,
    urls: widget.images
  );

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
    descriptionController.text = widget.description;
    latController.text = widget.lat == 0 ? "" : widget.lat.toString();
    lonController.text = widget.lon == 0 ? "" : widget.lon.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        final img = widget.images[index];
                        return AddImageItem(
                          img: img,
                          bloc: widget.bloc,
                        );
                      },
                    ),
                  ),
                  Text(
                    "КАТЕГОРИЯ",
                    style: TextStyleSet().textRegular.copyWith(
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Place.ruPlaceTypeNames[widget.placeType.index],
                          style: TextStyleSet().textRegular16.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SelectPlaceCategory(
                                  bloc: widget.bloc,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Delimer(),
                  ),
                  Text(
                    "НАЗВАНИЕ",
                    style: TextStyleSet().textRegular.copyWith(
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      //autofocus: true,
                      focusNode: nameNode,
                      decoration: const InputDecoration(
                        hintText: 'название',
                      ),
                      controller: nameController,
                      onSubmitted: (value) => latNode.requestFocus(),
                      onChanged: (value) =>
                          widget.bloc.add(AddPlaceChangeEvent(_currentPlace)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ШИРОТА",
                                style: TextStyleSet().textRegular.copyWith(
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 8, 0),
                                child: TextField(
                                  controller: latController,
                                  decoration: InputDecoration(
                                    hintText: 'широта',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.cancel_rounded),
                                      onPressed: () => latController.clear(),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  focusNode: latNode,
                                  onSubmitted: (value) => lonNode.requestFocus(),
                                  onChanged: (value) => widget.bloc.add(AddPlaceChangeEvent(_currentPlace)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ДОЛГОТА",
                                  style: TextStyleSet().textRegular.copyWith(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: TextField(
                                    controller: lonController,
                                    focusNode: lonNode,
                                    onSubmitted: (value) =>
                                        descriptionNode.requestFocus(),
                                    decoration: InputDecoration(
                                      hintText: 'долгота',
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.cancel_rounded),
                                        onPressed: () => lonController.clear(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => widget.bloc.add(AddPlaceChangeEvent(_currentPlace)),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      child: Text(
                        "Указать на карте",
                        style: TextStyleSet().textMedium16.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapScreen(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                    decoration: const InputDecoration(
                      hintText: "введите текст",
                    ),
                    onChanged: (value) => widget.bloc.add(AddPlaceChangeEvent(_currentPlace)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () => widget.bloc.add(AddPlaceSaveEvent(_currentPlace)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
    );
  }
}
