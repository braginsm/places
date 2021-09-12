import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/place_list/place_list_bloc.dart';
import 'package:places/data/blocks/place_list/place_list_event.dart';
import 'package:places/data/blocks/place_list/place_list_state.dart';
import 'package:places/data/interactor/geo_interactor.dart';
import 'package:places/data/model/geo.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/search_place.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/add_new_place_widget.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/round_button.dart';
import 'widgets/sight_item.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  YandexMapController? controller;
  late PlaceListBloc _block;

  final String _mapStyle = '''
    [
      {
        "tags": {
          "all": ["road"]
        },
        "stylers": {
          "color": "fff"
        }
      },
      {
        "tags": {
          "all": ["water"]
        },
        "stylers": {
          "color": "c0c0c0"
        }
      },
      {
        "tags": {
          "all": ["landcover"]
        },
        "stylers": {
          "color": "dfdfdf"
        }
      },
      {
        "tags": {
          "all": ["region"]
        },
        "stylers": {
          "color": "9d9d9d"
        }
      }
    ]
  ''';

  Future<void> _setMapStyle() async {
    await controller!.setMapStyle(style: _mapStyle);
  }

  Future<void> _serTargetPoint() async {
    controller!.addPlacemark(Placemark(
      point: await controller!.getTargetPoint(),
      style: PlacemarkStyle(
        iconName: ImagesPaths.iAmHere,
      ),
    ));
  }

  Future<void> _moveCurrentPoint() async {
    final currentGeo = await context.read<GeoInteractor>().currentPosition;
    controller!.move(
      point:
          Point(latitude: currentGeo.latitude, longitude: currentGeo.longitude),
      zoom: 12,
    );
  }

  Future<void> _showPaceList(List<Place> list) async {
    for (Place item in list) {
      await controller!.addPlacemark(Placemark(
        point: Point(latitude: item.lat, longitude: item.lon),
        style: PlacemarkStyle(
          iconName: ImagesPaths.mapPoint,
        ),
      ));
    }
  }

  @override
  void initState() {
    _block = context.read<PlaceListBloc>()..add(PlaceListLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Карта"),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
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
          preferredSize: const Size(double.infinity, 64),
        ),
      ),
      body: BlocProvider<PlaceListBloc>(
        create: (BuildContext context) => _block,
        child: BlocBuilder<PlaceListBloc, PlaceListState>(
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                YandexMap(
                  onMapCreated:
                      (YandexMapController yandexMapController) async {
                    controller = yandexMapController;
                    _setMapStyle();
                    await _moveCurrentPoint();
                    await _serTargetPoint();
                    if (state is PlaceListLoadingSuccessState) {
                      _showPaceList(state.placeList);
                    }
                  },
                  onMapTap: (Point point) => _block.add(PlaceListMapTapEvent(
                      Geo(point.latitude, point.longitude))),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RoundButton(
                                iconPath: ImagesPaths.refresh,
                                onPressed: () => context
                                    .read<PlaceListBloc>()
                                    .add(PlaceListLoadEvent()),
                              ),
                              if (state is! PlaceListShowPlaceOnMapState)
                                const AddNewPlaceButton(),
                              RoundButton(
                                iconPath: ImagesPaths.geolocation,
                                onPressed: _moveCurrentPoint,
                              ),
                            ],
                          ),
                          if (state is PlaceListShowPlaceOnMapState)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: SightItem(
                                key: Key(state.place.key),
                                place: state.place,
                                favoritAction: true,
                                goAction: true,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        activeIndex: 1,
      ),
    );
  }
}
