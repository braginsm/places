import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/filters.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool readOnly;

  final Function onTap;

  final TextEditingController controller;

  const SearchBar({Key key, this.readOnly = false, this.onTap, this.controller})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController fieldController = TextEditingController();

  final textFieldFocusNode = FocusNode();

  bool _suffixTap = false;

  void onFilterPress() {
    setState(() {
      _suffixTap = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FiltersScreen()));
  }

  void onClearPress() {
    fieldController.clear();
    context.read<SerachInteractor>().search("");
  }

  @override
  void initState() {
    super.initState();
    if (context.read<SerachInteractor>().searchBarController != null) {
      fieldController = context.read<SerachInteractor>().searchBarController;
    }
  }

  @override
  Widget build(BuildContext context) {
    _suffixTap = false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
      ),
      child: Center(
        child: TextField(
          focusNode: textFieldFocusNode,
          // ignore: avoid_print
          onChanged: (value) => /*StoreProvider.of<AppState>(context).dispatch(LoadSearch(value))*/print(value),
          controller: fieldController,
          readOnly: widget.readOnly,
          onTap: () {
            if (!_suffixTap && widget.onTap != null) widget.onTap();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: SvgPicture.asset(
                ImagesPaths.search,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 44,
            ),
            suffixIcon: IconButton(
              onPressed: widget.readOnly ? onFilterPress : onClearPress,
              icon: widget.readOnly
                  ? SvgPicture.asset(
                      ImagesPaths.filter,
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(
                      Icons.cancel,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 44,
            ),
          ),
        ),
      ),
    );
  }
}
