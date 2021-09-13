import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/interactor/place_visit_interactor.dart';
import 'package:places/data/model/place_visit.dart';
import 'package:places/ui/res/images.dart';
import 'package:provider/provider.dart';
import 'package:places/data/model/place.dart';

class PlaceMapButton extends StatefulWidget {
  final Place place;
  const PlaceMapButton({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceMapButtonState createState() => _PlaceMapButtonState();
}

class _PlaceMapButtonState extends State<PlaceMapButton> {

  _showInMap() async {
    context.read<PlaceVisitInteractor>().addPlace(PlaceVisit.fromPlace(widget.place, DateTime.now()));
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: Coords(widget.place.lat, widget.place.lon), 
      destinationTitle: widget.place.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      onPressed: _showInMap,
      icon: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            ImagesPaths.go,
            color: Theme.of(context).canvasColor,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
