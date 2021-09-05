import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/place_list/place_list_bloc.dart';
import 'package:places/data/blocks/place_list/place_list_event.dart';
import 'package:places/data/blocks/place_list/place_list_state.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/network_exeption.dart';
import 'package:places/ui/screen/search_place.dart';
import 'package:places/ui/screen/smth_error.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';

import 'package:provider/provider.dart';

import 'widgets/add_new_place_widget.dart';
import 'widgets/preloader.dart';

class SightListScreen extends StatelessWidget {
  const SightListScreen({Key? key}) : super(key: key);
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
                  const SliverAppBar(
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
                      preferredSize: const Size(double.infinity, 64),
                      child: SearchBar(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPlaceScreen(),
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
            const Positioned(
              bottom: 16,
              child: AddNewPlaceButton(),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class StreamSliverList extends StatefulWidget {
  final Orientation orientation;

  const StreamSliverList(this.orientation, {Key? key}) : super(key: key);

  @override
  _StreamSliverListState createState() => _StreamSliverListState();
}

class _StreamSliverListState extends State<StreamSliverList> {
  late PlaceListBloc _bloc;

  @override
  void initState() {
    super.initState();
    try {
      _bloc = PlaceListBloc(context.read<PlaceInteractor>())
        ..add(PlaceListLoadEvent());
    } on NetworkExeption catch (_) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const SmthError();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlaceListBloc>(
      create: (context) => _bloc,
      child: BlocBuilder<PlaceListBloc, PlaceListState>(
        builder: (context, state) {
          if (state is PlaceListLoadingInProgressState) {
            return const SliverPreloader();
          }
          if (state is PlaceListLoadingSuccessState) {
            return SightSliverList(state.placeList, widget.orientation);
          }
          throw ArgumentError("Неожиданное состояние в _StreamSliverListState");
        },
      ),
    );
  }
}

class SightSliverList extends StatelessWidget {
  final List<Place?> placeList;
  final Orientation orientation;
  const SightSliverList(this.placeList, this.orientation, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (orientation == Orientation.portrait)
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = placeList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SightItem(
                    place: item!,
                    favoritAction: true,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SightItem(
                    place: item!,
                    favoritAction: true,
                  ),
                );
              },
              childCount: placeList.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
          );
  }
}

class SliverPreloader extends StatelessWidget {
  const SliverPreloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: PreloaderWidget(),
      ),
    );
  }
}
