import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_favorit_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_favorit.dart';
import 'package:provider/provider.dart';

import 'package:places/data/blocks/place/place_bloc.dart';
import 'package:places/data/blocks/place/place_event.dart';
import 'package:places/data/blocks/place/place_state.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/image_network.dart';

import '../res/text_styles.dart';
import 'widgets/preloader.dart';
import 'widgets/round_button.dart';

class PlaceCardScreen extends StatefulWidget {
  final int id;
  const PlaceCardScreen(this.id, {Key? key}) : super(key: key);

  @override
  _PlaceCardScreenState createState() => _PlaceCardScreenState();
}

class _PlaceCardScreenState extends State<PlaceCardScreen> {
  late PlaceBloc _bloc;

  @override
  void initState() {
    _bloc = PlaceBloc(context.read<PlaceInteractor>())
      ..add(PlaceLoadingEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<PlaceBloc>(
          create: (BuildContext context) => _bloc,
          child: BlocBuilder<PlaceBloc, PlaceState>(
            builder: (BuildContext context, PlaceState state) {
              if (state is PlaceLoadingInProgressState) {
                return const PreloaderWidget();
              }
              if (state is PlaceShowState) {
                return PlaceWidget(state.place);
              }
              throw ArgumentError(
                  "Непредусмотренное состояние в _PlaceCardScreenState");
            },
          ),
        ),
      ),
    );
  }
}

class PlaceWidget extends StatefulWidget {
  final Place place;

  const PlaceWidget(this.place, {Key? key}) : super(key: key);

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  int _curentImage = 0;
  bool _inFavorit = false;

  @override
  void initState() {
    super.initState();
    _setInFavorit();
  }

  void _setInFavorit() async {
    final _res =
        await context.read<PlaceFavoritInteractor>().inFavorit(widget.place);
    setState(() {
      _inFavorit = _res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: 360,
          flexibleSpace: FlexibleSpaceBar(
            background: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: widget.place.urls.length,
                    onPageChanged: (value) {
                      setState(() {
                        _curentImage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = widget.place.urls[index];
                      return SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: widget.place.id,
                          child: ImageNetworkWithPlaceholder(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 8,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          for (var i = 0; i < widget.place.urls.length; i++)
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _curentImage == i
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: RoundButton(
                      iconPath: ImagesPaths.close, 
                      onPressed: () => Navigator.pop(context),
                    ), 
                  )
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.name,
                  style: TextStyleSet()
                      .textBold24
                      .copyWith(color: Theme.of(context).primaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Text(
                        widget.place.placeTypeName,
                        style: TextStyleSet()
                            .textBold
                            .copyWith(color: Theme.of(context).hintColor),
                        maxLines: 1,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Text(
                            "закрыто до 09:00",
                            style: TextStyleSet().textRegular.copyWith(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                ),
                            maxLines: 1,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    widget.place.description,
                    style: TextStyleSet().textRegular.copyWith(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      // ignore: avoid_print
                      print("Построить маршрут");
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(ImagesPaths.buildRoute),
                            ),
                            Text(
                              "ПОСТРОИТЬ МАРШРУТ",
                              style: TextStyleSet().textBold.copyWith(
                                  color: Theme.of(context).canvasColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  width: double.infinity,
                  height: 1.6,
                  color:
                      Theme.of(context).unselectedWidgetColor.withOpacity(0.24),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () async {
                            var res = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 90)),
                            );
                            // ignore: avoid_print
                            print(res);
                            // if (res != null) {
                            //   mocks[mocks.indexOf(_place)].wontDate =
                            //       res;
                            //   setState(() {
                            //     _inWont = mocks[mocks.indexOf(_place)].wontVisit;
                            //   });
                            // }
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  ImagesPaths.toPlan,
                                  color: _inFavorit
                                      ? Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.56)
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                'Запланировать',
                                style: TextStyleSet().textRegular.copyWith(
                                      color: _inFavorit
                                          ? Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.56)
                                          : Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () => context
                              .read<PlaceFavoritInteractor>()
                              .addPlace(
                                  PlaceFavorit.fromPlace(widget.place, 1)),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    ImagesPaths.heart,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  )),
                              Text(
                                'В Избранное',
                                style: TextStyleSet().textRegular.copyWith(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
