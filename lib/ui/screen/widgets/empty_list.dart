import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';

class EmptyListWont extends StatelessWidget {
  final icon = SizedBox(
    width: 64,
    height: 64,
    child: SvgPicture.asset(ImagesPaths.card),
  );
  final title = "Пусто";
  final description = "Отмечайте понравившиеся места и они появиятся здесь.";

  EmptyListWont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Text(
              title,
              style: TextStyleSet().textMedium18.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.56),
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 53, vertical: 8),
            child: Text(
              description,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyleSet().textRegular.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(0.56)),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyListVisited extends EmptyListWont {
  EmptyListVisited({Key? key}) : super(key: key);

  @override
  final icon = SizedBox(
    width: 64,
    height: 64,
    child: SvgPicture.asset(ImagesPaths.go),
  );

  @override
  final description = "Завершите маршрут, чтобы место попало сюда.";
}
