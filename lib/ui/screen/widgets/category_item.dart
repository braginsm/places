import 'dart:html';

import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool select;
  const CategoryItemWidget({Key key, @required this.title, this.onTap, this.select})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyleSet()
            .textRegular16
            .copyWith(color: Theme.of(context).hintColor),
      ),
      trailing: select ? Icon(Icons.check) : SizedBox.expand(),
      onTap: onTap,
    );
  }
}
