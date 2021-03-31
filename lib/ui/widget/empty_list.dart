import 'package:flutter/material.dart';
import '../res/text_styles.dart';

class EmptyListSight extends StatelessWidget {
  const EmptyListSight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Container(
          width: 64,
          height: 64,
          color: Color(0xff7C7E92).withOpacity(0.56),
        ),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: Text("Пусто",
              style: TextStyleSet().textMedium18.copyWith(
                  color: Color(0xff7C7E92).withOpacity(0.56))),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 53, vertical: 8),
          child: Text(
            "Отмечайте понравившиеся места и они появиятся здесь.",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyleSet().textRegular.copyWith(
                color: Color(0xff7C7E92).withOpacity(0.56)),
          ),
        ),
      ]),
    );
  }
}
