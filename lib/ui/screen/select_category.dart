import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_bloc.dart';
import 'package:places/data/blocks/add_place/add_place_event.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

import 'widgets/category_item.dart';
import 'widgets/delimer.dart';

class SelectPlaceCategory extends StatefulWidget {
  SelectPlaceCategory({Key key}) : super(key: key);

  @override
  _SelectPlaceCategoryState createState() => _SelectPlaceCategoryState();
}

class _SelectPlaceCategoryState extends State<SelectPlaceCategory> {
  int _selectIndex;
  AddPlaceBloc _bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 15,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Категория"),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: PlaceType.values.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CategoryItemWidget(
                        title: Place.ruPlaceTypeNames[index],
                        onTap: () => _changeSelectIndex(index),
                        select: index == _selectIndex,
                      ),
                      Delimer(),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Container(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _selectIndex != null
                    ? _bloc.add(AddPlaceTypeChangeEvent(PlaceType.values[_selectIndex]))
                    : null,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _selectIndex != null
                              ? Theme.of(context).accentColor
                              : Theme.of(context).backgroundColor)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      child: Text(
                        "СОХРАНИТЬ",
                        style: TextStyleSet().textBold.copyWith(
                            color: _selectIndex != null
                                ? Theme.of(context).canvasColor
                                : Theme.of(context).unselectedWidgetColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeSelectIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}
