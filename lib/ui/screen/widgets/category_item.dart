import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  const CategoryItemWidget({Key key, @required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyleSet()
                .textRegular16
                .copyWith(color: Theme.of(context).hintColor),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 10,),
            onPressed: onTap,
          )
        ],
      ),
    );
  }
}
