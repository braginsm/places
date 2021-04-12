import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';

class SearchBar extends StatelessWidget {
  bool readOnly = false;

  Function onTap = () {};

  SearchBar({Key key, this.readOnly = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
      ),
      child: Center(
        child: TextField(
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            hintText: "Поиск",
            hintStyle: TextStyleSet()
                .textRegular16
                .copyWith(color: Theme.of(context).unselectedWidgetColor),
            isDense: true,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            fillColor: Theme.of(context).backgroundColor,
            focusColor: Theme.of(context).backgroundColor,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: SvgPicture.asset(
                ImagesPaths.search,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 40,
              maxWidth: 44,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: SvgPicture.asset(
                ImagesPaths.filter,
                color: Theme.of(context).accentColor,
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              maxHeight: 40,
              maxWidth: 44,
            ),
          ),
        ),
      ),
    );
  }
}
