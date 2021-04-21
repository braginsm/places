import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/empty_list.dart';
import 'package:places/ui/screen/widgets/image_network.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';
import '../res/text_styles.dart';
import '../../mocks.dart';
import './widgets/bottom_navigation.dart';
import '../../domain/sight.dart';
import 'package:provider/provider.dart';

class VisitingState with ChangeNotifier {

  List<Sight> _wontList = mocks.where((f) => f.wontVisit).toList();
  List<Sight> _visitList = mocks.where((f) => f.visit).toList();

  List<Sight> get wontList => _wontList;
  List<Sight> get visitList => _visitList;

  //TODO: когда появятся идентификаторы мест, пердлать на них.
  void removeWont(String name) {
    for (var i = 0; i < mocks.length; i++)
      if (mocks[i].name == name) mocks[i].wontDate = null;
    notifyListeners();
  }

  //TODO: когда появятся идентификаторы мест, пердлать на них.
  void removeVisit(String name) {
    for (var i = 0; i < mocks.length; i++)
      if (mocks[i].name == name) mocks[i].visitDate = null;
    notifyListeners();
  }

  void moveWont(Sight after, Sight sight) {
    _wontList.remove(sight);
    _wontList.insert(_wontList.indexOf(after) + 1, sight);
    notifyListeners();
  }

  void moveVizit(Sight after, Sight sight) {
    _wontList.remove(sight);
    _wontList.insert(_wontList.indexOf(after) + 1, sight);
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
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: context.watch<VisitingState>().wontList.length > 0
                    ? Column(children: [
                        for (var item
                            in context.watch<VisitingState>().wontList)
                          Column(
                            children: [
                              SightItem(
                                item,
                                onDismissed: (dismissDirection) => context
                                    .read<VisitingState>()
                                    .removeWont(item.name),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      print("Календарь");
                                    },
                                    icon: SvgPicture.asset(
                                      ImagesPaths.calendar,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<VisitingState>()
                                          .removeWont(item.name);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ],
                              ),
                              DragTarget<Sight>(
                                onAccept: (sight) {
                                  print(
                                      "отпустил ${sight.name} под ${item.name}");
                                  context
                                    .read<VisitingState>()
                                    .moveWont(item, sight);
                                },
                                builder: (context, a, b) {
                                  // КОнтейнер для приема виджета при сортировке
                                  return Container(
                                    width: double.infinity,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ); // : SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                      ])
                    : EmptyListWont(),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: context.watch<VisitingState>().visitList.length > 0
                    ? Column(children: [
                        for (var item
                            in context.watch<VisitingState>().visitList)
                          SightItem(
                            item,
                            onDismissed: (dismissDirection) => context
                                .read<VisitingState>()
                                .removeWont(item.name),
                            actions: [
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
                                      .removeVisit(item.name);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ],
                          ),
                      ])
                    : EmptyListVisited(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class VisitItem extends StatelessWidget {
  final Sight sight;
  const VisitItem(this.sight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(children: [
        Container(
          child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: ImageNetwork(sight.url, fit: BoxFit.fitWidth),
                  )),
              Container(
                margin: EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  sight.type,
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).canvasColor),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    sight.wontVisit
                        ? context.read<VisitingState>().removeWont(sight.name)
                        : context.read<VisitingState>().removeVisit(sight.name);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
              Positioned(
                right: 36,
                child: IconButton(
                  onPressed: () {
                    print(sight.wontVisit ? "Календарь" : "Поделиться");
                  },
                  icon: SvgPicture.asset(
                    sight.wontVisit ? ImagesPaths.calendar : ImagesPaths.share,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 102,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  sight.name,
                  style: TextStyleSet()
                      .textMedium16
                      .copyWith(color: Theme.of(context).secondaryHeaderColor),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                height: 28,
                child: Text(
                  sight.wontVisit
                      ? "Запланировано на 12 окт. 2020"
                      : "Цель достигнута 12 окт. 2020",
                  style: TextStyleSet().textRegular.copyWith(
                        color: sight.wontVisit
                            ? Theme.of(context).accentColor
                            : Theme.of(context).hintColor,
                      ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                child: Text(
                  "закрыто до 09:00",
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
