import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';

class SmthError extends StatelessWidget {
  const SmthError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(ImagesPaths.delete),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Text(
                "Ошибка",
                style: TextStyleSet().textMedium18.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54),
              child: Text(
                "Что то пошло не так.\r\nПопробуйте позже.",
                style: TextStyleSet().textRegular.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
