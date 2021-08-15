import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/place_favorit.dart';

import 'package:places/ui/screen/widgets/sight_bottomsheet.dart';

import '../place_card.dart';
import 'image_network.dart';

class SightItem extends StatelessWidget {
  final Place sight;
  final bool? favoritAction;
  final List<Widget>? actions;
  const SightItem(
    this.sight, {
    Key? key,
    this.actions = const <Widget>[],
    this.favoritAction,
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
                  tag: sight.id,
                  child: ImageNetworkWithPlaceholder(
                    sight.urls.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  sight.name,
                  style: TextStyleSet()
                      .textMedium16
                      .copyWith(color: Theme.of(context).secondaryHeaderColor),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              // if (sight.wontVisit || sight.visit)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              //     child: Text(
              //       sight.visit
              //           ? "Цель достигнута ${DateFormat.yMMMd().format(sight.visitDate)}"
              //           : "Запланировано на ${DateFormat.yMMMd().format(sight.wontDate)}",
              //       style: TextStyleSet().textRegular.copyWith(
              //             color: sight.visit
              //                 ? Theme.of(context).hintColor
              //                 : Theme.of(context).accentColor,
              //           ),
              //       textAlign: TextAlign.left,
              //     ),
              //   ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Text(
                  "закрыто до 09:00",
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Text(
                  sight.description,
                  style: TextStyleSet()
                      .textRegular16
                      .copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 16,
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
                  return SightBottomheet(sight: sight);
                },
                isScrollControlled: true,
              ),
              onLongPress: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return SafeArea(child: Scaffold(body: PlaceWidget(sight)));
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
                if (favoritAction!) PlaceFavoritWidget(sight)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              sight.placeTypeName,
              style: TextStyleSet()
                  .textRegular
                  .copyWith(color: Theme.of(context).canvasColor),
            ),
          ),
        ],
      ),
    );
  }
}

class DismissibleSightItem extends StatelessWidget {
  final Place sight;
  final List<Widget> actions;
  final Function(DismissDirection) onDismissed;
  const DismissibleSightItem(this.sight,
      {Key? key, this.actions = const [], required this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(sight),
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
        sight,
        actions: actions,
      ),
    );
  }
}
