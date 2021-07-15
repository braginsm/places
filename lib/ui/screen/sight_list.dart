import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/NetworkExeption.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';
import 'package:places/data/store/place_list/place_list_store.dart';

import 'package:provider/provider.dart';
import 'package:places/ui/screen/visiting.dart';

import '../res/text_styles.dart';
import 'add_place/add_place_screen.dart';
import 'add_place/add_place_wm.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            OrientationBuilder(builder: (context, orientation) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leadingWidth: 0,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    expandedHeight: 150,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        "Список интересных мест",
                        maxLines: 2,
                      ),
                      centerTitle: true,
                      titlePadding: EdgeInsets.all(16),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PreferredSize(
                      preferredSize: Size(double.infinity, 64),
                      child: SearchBar(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SightSearchScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  StreamSliverList(orientation),
                ],
              );
            }),
            Positioned(
              bottom: 16,
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => AddPlaceScreen(
                        widgetModelBuilder: (BuildContext context) { return context.read<AddPlaceScreenWidgetModel>(); },
                      ),
                    ),
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).tabBarTheme.labelColor,
                        ),
                        Text(
                          " НОВОЕ МЕСТО",
                          style: TextStyleSet().textBold.copyWith(
                              color: Theme.of(context).tabBarTheme.labelColor),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).indicatorColor,
                      Theme.of(context).accentColor
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class StreamSliverList extends StatefulWidget {
  final Orientation orientation;

  StreamSliverList(this.orientation, {Key key}) : super(key: key);

  @override
  _StreamSliverListState createState() => _StreamSliverListState();
}

class _StreamSliverListState extends State<StreamSliverList> {
  StreamController _controller = new StreamController<List<Place>>();
  PlaceListStore _store;

  @override
  void initState() {
    super.initState();
    _store = PlaceListStore(context.read<PlaceInteractor>());
    try {
      _store.getPlaceList();
    } on NetworkExeption catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return SmthError();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<PlaceListStore>(
      create: (_) => _store,
      child: Observer(
        builder: (BuildContext context) {
          return (_store.getPlaceListFuture.status == FutureStatus.pending)
              ? SliverPreloader()
              : SightSliverList(
                  _store.getPlaceListFuture.value, widget.orientation);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class SightSliverList extends StatelessWidget {
  final List<Place> placeList;
  final Orientation orientation;
  const SightSliverList(this.placeList, this.orientation, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (orientation == Orientation.portrait)
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = placeList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SightItem(
                    item,
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.read<PlaceListStore>().toggleFavorites(item);
                        },
                        icon: SvgPicture.asset(
                          ImagesPaths.favorite,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: placeList.length,
            ),
          )
        : SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = placeList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SightItem(
                    item,
                    actions: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<VisitingState>()
                              .setWont(item, DateTime.now());
                        },
                        icon: SvgPicture.asset(
                          ImagesPaths.favorite,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: placeList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
          );
  }
}

class SliverPreloader extends StatelessWidget {
  const SliverPreloader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
