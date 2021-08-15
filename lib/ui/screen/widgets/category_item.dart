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
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyleSet()
                    .textRegular16
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: select ? Icon(
                  Icons.check,
                  color: Theme.of(context).accentColor,
                ) : const SizedBox.expand(),
              ) 
            ),
          ],
        ),
      ),
    );
  }
}
