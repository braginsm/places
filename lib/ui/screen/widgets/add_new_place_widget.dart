import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

import '../add_place.dart';

class AddNewPlaceButton extends StatelessWidget {
  const AddNewPlaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => const AddPlaceScreen(),
          ),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Theme.of(context).tabBarTheme.labelColor,
              ),
              Text(
                " НОВОЕ МЕСТО",
                style: TextStyleSet().textBold.copyWith(
                    color: Theme.of(context).tabBarTheme.labelColor),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [
            Theme.of(context).indicatorColor,
            Theme.of(context).colorScheme.secondary
          ]),
        ),
      ),
    );
  }
}