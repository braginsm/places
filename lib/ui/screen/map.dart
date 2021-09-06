import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/geo_interactor.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/search_place.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/add_new_place_widget.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/round_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController controller;

  late Point _currentPoint;
  late Placemark _currentPlacemark;

  Future<void> _setCurrentPoint() async {
    final currentGeo = await context.read<GeoInteractor>().currentPosition;
    _currentPoint =
        Point(latitude: currentGeo.latitude, longitude: currentGeo.longitude);
  }

  Future<Placemark> _getCurrentPlacemark() async {
    await _setCurrentPoint();
    return Placemark(
      point: _currentPoint,
      style: PlacemarkStyle(
        iconName: ImagesPaths.iAmHere,
      ),
    );
  }

  void _onMapRendered() async {
    await controller.addPlacemark(await _getCurrentPlacemark());
    await _moveCurrentPoint();
  }

  Future<void> _moveCurrentPoint() async {
    await controller.move(point: _currentPoint, zoom: 12);
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
            onMapTap: (Point point) =>
                print('Tapped map at ${point.latitude},${point.longitude}'),
            onMapLongTap: (Point point) => print(
                'Long tapped map at ${point.latitude},${point.longitude}')),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButton(
                      iconPath: ImagesPaths.refresh,
                      onPressed: () {},
                    ),
                    const AddNewPlaceButton(),
                    RoundButton(
                      iconPath: ImagesPaths.geolocation,
                      onPressed: _moveCurrentPoint,
                    ),
                  ]),
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
