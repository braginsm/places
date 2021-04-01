import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import '../res/text_styles.dart';

class EmptyListWont extends StatelessWidget {
  final icon = Container(
    width: 64,
    height: 64,
    color: ColorsSet.secondary2.withOpacity(0.56),
  );
  final title = "Пусто";
  final description = "Отмечайте понравившиеся места и они появиятся здесь.";

  EmptyListWont({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Container(
            margin: EdgeInsets.only(top: 24),
            child: Text(title,
                style: TextStyleSet()
                    .textMedium18
                    .copyWith(color: ColorsSet.secondary2.withOpacity(0.56))),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 53, vertical: 8),
            child: Text(
              description,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyleSet()
                  .textRegular
                  .copyWith(color: ColorsSet.secondary2.withOpacity(0.56)),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyListVisited extends EmptyListWont {
  final icon = Container(
    width: 64,
    height: 64,
    color: ColorsSet.secondary2.withOpacity(0.56),
  );
  final description = "Завершите маршрут, чтобы место попало сюда.";
}
