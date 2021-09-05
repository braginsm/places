import 'package:flutter/material.dart';
import 'package:places/ui/screen/search_place.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/add_new_place_widget.dart';
import 'widgets/bottom_navigation.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  YandexMapController? controller;

  bool isNightModeEnabled = false;

  bool isZoomGesturesEnabled = false;

  bool isTiltGesturesEnabled = false;

  static const Point _point = Point(latitude: 59.945933, longitude: 30.320045);

  final String emptyStyle = '''
    [
      {
        "tags": {
          "all": ["landscape"]
        },
        "stylers": {
          "saturation": 0,
          "lightness": 0
        }
      }
    ]
  ''';

  final String nonEmptyStyle = '''
    [
      {
        "tags": {
          "all": ["landscape"]
        },
        "stylers": {
          "color": "f00",
          "saturation": 0.5,
          "lightness": 0.5
        }
      }
    ]
  ''';

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
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          YandexMap(
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
            },
            onMapRendered: () async {
              print('Map rendered');
              var tiltGesturesEnabled = await controller!.isTiltGesturesEnabled();
              var zoomGesturesEnabled = await controller!.isZoomGesturesEnabled();
        
              var zoom    = await controller!.getZoom();
              var minZoom = await controller!.getMinZoom();
              var maxZoom = await controller!.getMaxZoom();
        
              print('Current zoom: $zoom, minZoom: $minZoom, maxZoom: $maxZoom');
        
              setState(() {
                isTiltGesturesEnabled = tiltGesturesEnabled;
                isZoomGesturesEnabled = zoomGesturesEnabled;
              });
            },
            onMapSizeChanged: (MapSize size) => print('Map size changed to ${size.width}x${size.height}'),
            onMapTap: (Point point) => print('Tapped map at ${point.latitude},${point.longitude}'),
            onMapLongTap: (Point point) => print('Long tapped map at ${point.latitude},${point.longitude}')
          ),
          const AddNewPlaceButton(),
        ]
      ),
      bottomNavigationBar: const BottomNavigation(activeIndex: 1,),
    );
  }
}