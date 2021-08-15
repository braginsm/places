import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/images.dart';

class PlaceFavoritWidget extends StatefulWidget {
  final Place? place;
  final Color? color;
  const PlaceFavoritWidget(this.place, {Key? key, this.color}) : super(key: key);

  @override
  _PlaceFavoritWidgetState createState() => _PlaceFavoritWidgetState();
}

class _PlaceFavoritWidgetState extends State<PlaceFavoritWidget> {
  Widget? _heart;
  Widget? _heartFull;
  Widget? _child;

  @override
  void initState() {
    _heart = SvgPicture.asset(
      ImagesPaths.heart,
      key: UniqueKey(),
      color: widget.color,
    );
    _heartFull = SvgPicture.asset(
      ImagesPaths.heartFull,
      key: UniqueKey(),
      color: widget.color,
    );
    _child = (favoriteList.contains(widget.place)) ? _heartFull : _heart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _togleFavorit(widget.place),
      icon: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _child,
      ),
    );
  }

  void _togleFavorit(Place? place) {
    Widget? _current;
    if (favoriteList.contains(place)) {
      favoriteList.remove(place);
      _current = _heart;
    } else {
      favoriteList.add(place);
      _current = _heartFull;
    }

    setState(() {
      _child = _current;
    });
  }
}
