import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

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
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(index.toString()),
                    );
                  },
                ),
                Container(
                  width: double.infinity,
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
              ]),
        ),
      ),
    );
  }
}
