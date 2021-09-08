import 'package:flutter/material.dart';
import 'package:places/data/interactor/geo_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
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
  late YandexMapController controller;

  late List<Place> _listPlace;

  bool _showPlaceCart = false;

  Place? _placeShow;

  void _onMapRendered() async {
    await controller.addPlacemark(Placemark(
      point: await controller.getTargetPoint(),
      style: PlacemarkStyle(
        iconName: ImagesPaths.iAmHere,
      ),
    ));
    await _moveCurrentPoint();
  }

  Future<void> _moveCurrentPoint() async {
    final currentGeo = await context.read<GeoInteractor>().currentPosition;
    await controller.move(
        point: Point(
            latitude: currentGeo.latitude, longitude: currentGeo.longitude),
        zoom: 12,
    );
  }

  Future<void> _showPaceList() async {
    for (Place item in _listPlace) {
      await controller.addPlacemark(Placemark(
        point: Point(latitude: item.lat, longitude: item.lon),
        style: PlacemarkStyle(
          iconName: ImagesPaths.mapPoint,
        ),
      ));
    }
  }

  Future<void> _getPlaceList() async {
    final list = await context.read<PlaceInteractor>().getPlaces();
    setState(() {
      _listPlace = list;
    });
  }

  _init() async {
    await _getPlaceList();
    await _showPaceList();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  _onMapTap(Point point) async {
    try {
      final place = _listPlace.where((element) =>
        element.getDistans(Geo(point.latitude, point.longitude)) <= 300);
      setState(() {
        _placeShow = place.first;
        _showPlaceCart = true;
      });
    } catch (_) {
      setState(() {
        _showPlaceCart = false;
      });
    }
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
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        YandexMap(
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
            },
            onMapRendered: _onMapRendered,
            onMapSizeChanged: (MapSize size) =>
                print('Map size changed to ${size.width}x${size.height}'),
            onMapTap: _onMapTap,
            onMapLongTap: (Point point) => print(
                'Long tapped map at ${point.latitude},${point.longitude}')),
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
                        onPressed: () {},
                      ),
                      if (!_showPlaceCart) const AddNewPlaceButton(),
                      RoundButton(
                        iconPath: ImagesPaths.geolocation,
                        onPressed: _moveCurrentPoint,
                      ),
                    ],
                  ),
                  if (_showPlaceCart && _placeShow != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SightItem(
                        place: _placeShow!,
                        favoritAction: true,
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: const BottomNavigation(
        activeIndex: 1,
      ),
    );
  }
}
