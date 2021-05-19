import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/empty_list.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';
import '../res/text_styles.dart';
import './widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class VisitingState with ChangeNotifier {
  List<Place> get wontList => PlaceInteractor().getFavoritesPlaces();
  List<Place> get visitList => PlaceInteractor().getVisitPlaces();

  bool _showTarget = false;

  void togleShowTarget() {
    _showTarget = !_showTarget;
    notifyListeners();
  }

  bool get wontDragTarget => wontList.length > 1 && _showTarget;
  bool get visitDragTarget => visitList.length > 1 && _showTarget;

  void removeWont(Place sight) {
    PlaceInteractor().removeFromFavorites(sight);
    notifyListeners();
  }

  void removeVisit(Place sight) {
    PlaceInteractor().removeFromFavorites(sight);
    notifyListeners();
  }

  // void moveWont(Place after, Sight sight) {
  //   _wontList.remove(sight);
  //   _wontList.insert(_wontList.indexOf(after) + 1, sight);
  //   notifyListeners();
  // }

  // void moveVizit(Sight after, Sight sight) {
  //   _wontList.remove(sight);
  //   _wontList.insert(_wontList.indexOf(after) + 1, sight);
  //   notifyListeners();
  // }

  void setWont(Place place, DateTime date) {
    PlaceInteractor().addToFavorites(place);
    //mocks[mocks.indexOf(sight)].wontDate = date;
    notifyListeners();
  }

  void setVizit(Place place, DateTime date) {
    PlaceInteractor().addToVisitingPlaces(place);
    //mocks[mocks.indexOf(sight)].visitDate = date;
    notifyListeners();
  }
}

class VisitingScreen extends StatefulWidget {
  VisitingScreen({Key key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(vertical: 16),
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
            preferredSize: Size(double.infinity, 52),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                tabs: [Tab(text: "Хочу посетить"), Tab(text: "Посетил")],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            context.watch<VisitingState>().wontList.length > 0
                ? ListView.builder(
                    itemCount: context.watch<VisitingState>().wontList.length,
                    itemBuilder: (context, index) {
                      final item =
                          context.watch<VisitingState>().wontList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            DismissibleSightItem(
                              item,
                              onDismissed: (dismissDirection) => context
                                  .read<VisitingState>()
                                  .removeWont(item),
                              actions: [
                                Draggable<Place>(
                                  data: item,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.sort,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  feedback: Container(
                                    child: SightItem(item),
                                    width: 300,
                                  ),
                                  onDragStarted: () {
                                    context
                                        .read<VisitingState>()
                                        .togleShowTarget();
                                  },
                                  onDragEnd: (details) {
                                    context
                                        .read<VisitingState>()
                                        .togleShowTarget();
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
                                  onPressed: () {
                                    context
                                        .read<VisitingState>()
                                        .removeWont(item);
                                  },
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
                                // context
                                //     .read<VisitingState>()
                                //     .moveWont(item, sight);
                              },
                              show:
                                  context.watch<VisitingState>().wontDragTarget,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : EmptyListWont(),
            context.watch<VisitingState>().visitList.length > 0
                ? ListView.builder(
                    itemCount: context.watch<VisitingState>().visitList.length,
                    itemBuilder: (context, index) {
                      final item =
                          context.watch<VisitingState>().visitList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            DismissibleSightItem(
                              item,
                              onDismissed: (dismissDirection) => context
                                  .read<VisitingState>()
                                  .removeWont(item),
                              actions: [
                                Draggable<Place>(
                                  data: item,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.sort,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  feedback: Container(
                                    child: SightItem(item),
                                    width: 300,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print("Поделиться");
                                  },
                                  icon: SvgPicture.asset(
                                    ImagesPaths.share,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<VisitingState>()
                                        .removeVisit(item);
                                  },
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
                                // context
                                //     .read<VisitingState>()
                                //     .moveVizit(item, sight);
                              },
                              show: context
                                  .watch<VisitingState>()
                                  .visitDragTarget,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : EmptyListVisited(),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
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
        lastDate: DateTime.now().add(Duration(days: 90)),
      );
      context.read<VisitingState>().setWont(item, res);
    }
  }
}

class VisitingDragTarget extends StatelessWidget {
  final Place item;
  final bool show;
  final Function onAccept;
  const VisitingDragTarget(
      {Key key, @required this.item, this.show, this.onAccept(sight)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Place>(
      onAccept: onAccept,
      builder: (context, a, b) {
        return Container(
          width: double.infinity,
          height: show ? 20 : 0,
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
  const CupertinoWontDateModal(this.sight, {Key key}) : super(key: key);

  @override
  _CupertinoWontDateModalState createState() => _CupertinoWontDateModalState();
}

class _CupertinoWontDateModalState extends State<CupertinoWontDateModal> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Container(
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
                child: Text("Отмена"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                child: Text("ОК"),
                onPressed: () {
                  context
                      .read<VisitingState>()
                      .setWont(widget.sight, _dateTime);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
