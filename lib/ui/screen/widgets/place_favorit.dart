import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_favorit_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_favorit.dart';
import 'package:places/ui/res/images.dart';
import 'package:provider/provider.dart';

class PlaceFavoritWidget extends StatefulWidget {
  final Place place;
  final Color? color;
  const PlaceFavoritWidget(this.place, {Key? key, this.color})
      : super(key: key);

  @override
  _PlaceFavoritWidgetState createState() => _PlaceFavoritWidgetState();
}

class _PlaceFavoritWidgetState extends State<PlaceFavoritWidget> {
  late Widget _heart;
  late Widget _heartFull;
  bool _inFavorit = false;

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
    _setInFavorit();
    super.initState();
  }

  Future<void> _setInFavorit() async {
    final _res =
        await context.read<PlaceFavoritInteractor>().inFavorit(widget.place);
    setState(() {
      _inFavorit = _res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _togleFavorit(widget.place),
      icon: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _inFavorit ? _heartFull : _heart,
      ),
    );
  }

  Future<void> _togleFavorit(Place place) async {
    if (_inFavorit) {
      final _place =
          await context.read<PlaceFavoritInteractor>().getById(place.id);
      if (_place != null) {
        context.read<PlaceFavoritInteractor>().removePlace(_place);
      }
    } else {
      context
          .read<PlaceFavoritInteractor>()
          .addPlace(PlaceFavorit.fromPlace(place, 1));
    }

    setState(() {
      _inFavorit = !_inFavorit;
    });
  }
}
