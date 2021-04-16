import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import 'package:intl/intl.dart';

import 'image_network.dart';

class SightItem extends StatelessWidget {
  final Sight sight;
  final List<Widget> actions;
  const SightItem(
    this.sight, {
    Key key,
    this.actions = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16),
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
                      child: ImageNetwork(sight.url, fit: BoxFit.fitWidth),
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
                      style: TextStyleSet()
                          .textMedium16
                          .copyWith(color: Theme.of(context).secondaryHeaderColor),
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
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SightCard(sight))),
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
    );
  }
}
