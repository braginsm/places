import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/empty_list.dart';
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

  bool _showTarget = false;

  void togleShowTarget() {
    _showTarget = !_showTarget;
    notifyListeners();
  }

  bool get wontDragTarget => _wontList.length > 1 && _showTarget;
  bool get visitDragTarget => _visitList.length > 1 && _showTarget;

  //TODO: когда появятся идентификаторы мест, пердлать на них.
  void removeWont(Sight sight) {
    for (var i = 0; i < mocks.length; i++)
      if (mocks[i].name == sight.name) mocks[i].wontDate = null;
    _wontList.remove(sight);
    notifyListeners();
  }

  //TODO: когда появятся идентификаторы мест, пердлать на них.
  void removeVisit(Sight sight) {
    for (var i = 0; i < mocks.length; i++)
      if (mocks[i].name == sight.name) mocks[i].visitDate = null;
    _visitList.remove(sight);
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
                            SightItem(
                              item,
                              onDismissed: (dismissDirection) => context
                                  .read<VisitingState>()
                                  .removeWont(item),
                              actions: [
                                Draggable<Sight>(
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
                                context
                                    .read<VisitingState>()
                                    .moveWont(item, sight);
                              },
                              show: context
                                          .watch<VisitingState>()
                                          .wontDragTarget,
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
                            SightItem(
                              item,
                              onDismissed: (dismissDirection) => context
                                  .read<VisitingState>()
                                  .removeWont(item),
                              actions: [
                                Draggable<Sight>(
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
                                context
                                    .read<VisitingState>()
                                    .moveVizit(item, sight);
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
}

class VisitingDragTarget extends StatelessWidget {
  final Sight item;
  final bool show;
  final Function onAccept;
  const VisitingDragTarget({Key key, @required this.item, this.show, this.onAccept(sight)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
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
