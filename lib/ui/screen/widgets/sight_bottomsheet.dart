import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import '../sight_card.dart';

class SightBottomheet extends StatelessWidget {
  final Sight sight;

  const SightBottomheet({Key key, @required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              //child: SightCard(sight)
              child: SightCard(sight),
            ),
          ),
          Positioned(
            child: Icon(
              Icons.minimize_rounded,
              color: Theme.of(context).backgroundColor,
              size: 40,
            ),
            top: -12,
          )
        ],
      ),
    );
  }
}