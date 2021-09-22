import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocks/favorit_list/favorit_list_bloc.dart';
import 'package:places/data/blocks/favorit_list/favorit_list_event.dart';
import 'package:places/data/blocks/favorit_list/favorit_list_state.dart';
import 'package:places/data/blocks/visit_list/visit_list_event.dart';
import 'package:places/data/blocks/visit_list/vizit_list_bloc.dart';
import 'package:places/data/blocks/visit_list/vizit_list_state.dart';
import 'package:places/data/interactor/place_favorit_interactor.dart';
import 'package:places/data/interactor/place_visit_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_favorit.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/empty_list.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';
import '../res/text_styles.dart';
import './widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'widgets/preloader.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "Избранное",
                style: TextStyleSet()
                    .textMedium18
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 52),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const TabBar(
                tabs: [Tab(text: "Хочу посетить"), Tab(text: "Посетил")],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _FavoritTabItemWidget(),
            _VisitTabItemWidget(),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class VisitingDragTarget extends StatelessWidget {
  final Place? item;
  final bool? show;
  final Function onAccept;
  const VisitingDragTarget(
      {Key? key, required this.item, this.show, required this.onAccept(sight)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Place>(
      onAccept: onAccept as void Function(Place)?,
      builder: (context, a, b) {
        return Container(
          width: double.infinity,
          height: show! ? 20 : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).backgroundColor,
          ),
        ); // : SizedBox.shrink();
      },
    );
  }
}

class CupertinoWontDateModal extends StatefulWidget {
  final Place sight;
  const CupertinoWontDateModal(this.sight, {Key? key}) : super(key: key);

  @override
  _CupertinoWontDateModalState createState() => _CupertinoWontDateModalState();
}

class _CupertinoWontDateModalState extends State<CupertinoWontDateModal> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (res) {
                  setState(() {
                    _dateTime = res;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoButton(
                child: const Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: const Text("ОК"),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FavoritTabItemWidget extends StatefulWidget {
  const _FavoritTabItemWidget({Key? key}) : super(key: key);

  @override
  __FavoritTabItemWidgetState createState() => __FavoritTabItemWidgetState();
}

class __FavoritTabItemWidgetState extends State<_FavoritTabItemWidget> {
  late FavoritListBloc _block;
  bool _showTarget = false;

  @override
  void initState() {
    super.initState();
    _block = FavoritListBloc(context.read<PlaceFavoritInteractor>())
      ..add(FavoritListLoadEvent());
  }

  void _togleShowTarget() {
    setState(() {
      _showTarget = !_showTarget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritListBloc>(
      create: (context) => _block,
      child: BlocBuilder<FavoritListBloc, FavoritListState>(
        builder: (context, state) {
          if (state is FavoritListLoadingInProgress) {
            return const PreloaderWidget();
          }
          if (state is FavoritListLoadingSuccess) {
            final placeList = state.favoritList;
            return placeList.isEmpty
                ? const EmptyListWont()
                : ListView.builder(
                    itemCount: placeList.length,
                    itemBuilder: (context, index) {
                      final item = placeList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            DismissibleSightItem(
                              place: item,
                              onDismissed: (dismissDirection) => _block
                                  .add(VisitItemRemoveFromFavoritEvent(item)),
                              actions: [
                                Draggable<Place>(
                                  data: item,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.sort,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  feedback: SizedBox(
                                    child: SightItem(place: item, key: Key(item.key),),
                                    width: 300,
                                  ),
                                  onDragStarted: _togleShowTarget,
                                  onDragEnd: (details) {
                                    _togleShowTarget();
                                  },
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _showDatePicker(context, item),
                                  icon: SvgPicture.asset(
                                    ImagesPaths.calendar,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _block.add(
                                      VisitItemRemoveFromFavoritEvent(item)),
                                  icon: Icon(
                                    Icons.close,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ],
                            ),
                            VisitingDragTarget(
                              item: item,
                              onAccept: (sight) {
                                _block.add(FavoritItemMoveEvent(item, sight));
                              },
                              show: _showTarget,
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }
          throw ArgumentError("Неожиданное состояние в _FavoritTabItemWidget");
        },
      ),
    );
  }
}

Future<void> _showDatePicker(BuildContext context, Place item) async {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoWontDateModal(item),
    );
  } else {
    var res = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    context.read<PlaceFavoritInteractor>().addPlace(PlaceFavorit.fromPlace(item, 1));
  }
}

class _VisitTabItemWidget extends StatefulWidget {
  const _VisitTabItemWidget({Key? key}) : super(key: key);

  @override
  __VisitTabItemWidgetState createState() => __VisitTabItemWidgetState();
}

class __VisitTabItemWidgetState extends State<_VisitTabItemWidget> {
  late VisitListBloc _block;

  @override
  void initState() {
    super.initState();
    _block = VisitListBloc(context.read<PlaceVisitInteractor>())
      ..add(VisitListLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VisitListBloc>(
      create: (context) => _block,
      child: BlocBuilder<VisitListBloc, VisitListState>(
        builder: (context, state) {
          if (state is VisitListLoadingInProgress) {
            return const PreloaderWidget();
          }
          if (state is VisitListLoadingSuccess) {
            final placeList = state.visitList;
            return placeList.isEmpty
                ? const EmptyListVisited()
                : ListView.builder(
                    itemCount: placeList.length,
                    itemBuilder: (context, index) {
                      final item = placeList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            DismissibleSightItem(
                              place: item,
                              onDismissed: (dismissDirection) => _block
                                  .add(VisitItemRemoveFromVisitEvent(item)),
                              actions: [
                                Draggable<Place>(
                                  data: item,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.sort,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  feedback: SizedBox(
                                    child: SightItem(place: item, key: Key(item.key),),
                                    width: 300,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // ignore: avoid_print
                                    print("Поделиться");
                                  },
                                  icon: SvgPicture.asset(
                                    ImagesPaths.share,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _block
                                      .add(VisitItemRemoveFromVisitEvent(item)),
                                  icon: Icon(
                                    Icons.close,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }
          throw ArgumentError("Неожиданное состояние в _VisitTabItemWidget");
        },
      ),
    );
  }
}
