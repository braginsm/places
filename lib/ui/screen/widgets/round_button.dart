import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundButton extends StatelessWidget {
  final String iconPath;
  final Function() onPressed;
  const RoundButton({Key? key, required this.iconPath, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Center(
        child: IconButton(
          icon: SvgPicture.asset(
            iconPath,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
