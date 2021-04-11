import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/widget/delimer.dart';

class AddSightScreen extends StatefulWidget {
  AddSightScreen({Key key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            print("Отмена");
          },
          child: Text("Отмена"),
        ),
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Новое место"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "КАТЕГОРИЯ",
                  style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Не выбрано",
                        style: TextStyleSet().textRegular16.copyWith(color: Theme.of(context).hintColor),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 10,)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Delimer(),
                ),
                Text(
                  "НАЗВАНИЕ",
                  style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    
                  ),
                ),
                Center(child: Text("body")),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                onPressed: () => print("Создать"),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "СОЗДАТЬ",
                    style: TextStyleSet().textBold
                      .copyWith(color: Theme.of(context).canvasColor),
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
