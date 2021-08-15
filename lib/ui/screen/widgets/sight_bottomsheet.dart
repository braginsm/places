import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

import '../sight_card.dart';

class SightBottomheet extends StatelessWidget {
  final Place sight;

  const SightBottomheet({Key key, @required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              //child: SightCard(sight)
              child: SightCard(sight.id),
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