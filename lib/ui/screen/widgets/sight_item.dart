import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/place_favorit.dart';

import 'package:places/ui/screen/widgets/sight_bottomsheet.dart';

import '../place_card.dart';
import 'image_network.dart';
import 'place_map_button.dart';

class SightItem extends StatelessWidget {
  final Place place;
  final bool favoritAction;
  final bool goAction;
  final List<Widget>? actions;
  const SightItem({
    Key? key,
    this.actions = const <Widget>[],
    this.favoritAction = false,
    this.goAction = false,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 96,
                child: Hero(
                  tag: place.id,
                  child: ImageNetworkWithPlaceholder(
                    place.urls.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyleSet().textMedium16.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "закрыто до 09:00",
                                style: TextStyleSet().textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                place.description,
                                style: TextStyleSet().textRegular16.copyWith(
                                    color: Theme.of(context).hintColor),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Theme.of(context).hintColor.withOpacity(0.56),
              highlightColor: Colors.transparent,
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return SightBottomheet(sight: place);
                },
                isScrollControlled: true,
              ),
              onLongPress: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return SafeArea(child: Scaffold(body: PlaceWidget(place)));
                  },
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 188,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: [
                ...actions!,
                if (favoritAction) PlaceFavoritWidget(place)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              place.placeTypeName,
              style: TextStyleSet()
                  .textRegular
                  .copyWith(color: Theme.of(context).canvasColor),
            ),
          ),
          if (goAction)
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
                child: PlaceMapButton(place: place,),
              ),
            ),
        ],
      ),
    );
  }
}

class DismissibleSightItem extends StatelessWidget {
  final Place place;
  final List<Widget> actions;
  final Function(DismissDirection) onDismissed;
  const DismissibleSightItem(
      {Key? key,
      this.actions = const [],
      required this.onDismissed,
      required this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(place),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  ImagesPaths.basket,
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                "Удалить",
                style: TextStyleSet()
                    .textMedium
                    .copyWith(color: Theme.of(context).canvasColor),
              ),
            ],
          ),
        ),
      ),
      child: SightItem(
        place: place,
        actions: actions,
      ),
    );
  }
}
