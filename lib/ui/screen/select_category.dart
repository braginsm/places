import 'package:flutter/material.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/ui/res/text_styles.dart';

import 'widgets/category_item.dart';

class SelectPlaceCategory extends StatefulWidget {
  SelectPlaceCategory({Key key}) : super(key: key);

  @override
  _SelectPlaceCategoryState createState() => _SelectPlaceCategoryState();
}

class _SelectPlaceCategoryState extends State<SelectPlaceCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            // ListView.builder(
            //   itemCount: PlaceType.values.length,
            //   itemBuilder: (context, index) {
            //     return CategoryItemWidget(title: PlaceType.values[index].toString(),);
            //   },
            // ),
            Positioned(
              bottom: 16,
              child: Container(
                width: double.infinity,
                height: 20,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "СОХРАНИТЬ",
                      style: TextStyleSet()
                          .textBold
                          .copyWith(color: Theme.of(context).canvasColor),
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
}
