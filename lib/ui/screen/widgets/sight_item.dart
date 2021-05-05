import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'package:intl/intl.dart';

import 'image_network.dart';

class SightItem extends StatelessWidget {
  final Sight sight;
  final List<Widget> actions;
  final Function(DismissDirection) onDismissed;
  const SightItem(
    this.sight, {
    Key key,
    this.actions = const <Widget>[],
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(sight),
      onDismissed: onDismissed,
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
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
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            Column(children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 96,
                      child: ImageNetwork(sight.url[0], fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        sight.type,
                        style: TextStyleSet()
                            .textRegular
                            .copyWith(color: Theme.of(context).canvasColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        sight.name,
                        style: TextStyleSet().textMedium16.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),
                    if (sight.wontVisit || sight.visit)
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        width: double.infinity,
                        child: Text(
                          sight.visit
                              ? "Цель достигнута ${DateFormat.yMMMd().format(sight.visitDate)}"
                              : "Запланировано на ${DateFormat.yMMMd().format(sight.wontDate)}",
                          style: TextStyleSet().textRegular.copyWith(
                                color: sight.visit
                                    ? Theme.of(context).hintColor
                                    : Theme.of(context).accentColor,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      width: double.infinity,
                      child: Text(
                        "закрыто до 09:00",
                        style: TextStyleSet()
                            .textRegular
                            .copyWith(color: Theme.of(context).hintColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      width: double.infinity,
                      child: Text(
                        sight.details,
                        style: TextStyleSet()
                            .textRegular16
                            .copyWith(color: Theme.of(context).hintColor),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).hintColor.withOpacity(0.56),
                highlightColor: Colors.transparent,
                onTap: () => showBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: SightCard(sight)
                                ),
                                Positioned(
                                  child: Icon(
                                    Icons.minimize_rounded,
                                    color: Theme.of(context).backgroundColor,
                                    size: 40,
                                  ),
                                  top: 12,
                                )
                              ],
                            ),
                          );
                        },
                        onClosing: () {
                          print("Bottomsheet close");
                        },
                      );
                    }),
                child: Container(
                  width: double.infinity,
                  height: 188,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Row(
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
