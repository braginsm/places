import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/widget/delimer.dart';

class AddSightScreen extends StatefulWidget {
  AddSightScreen({Key key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode latNode = FocusNode();
  FocusNode lonNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  Sight newSight = Sight();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            nameController.clear();
            latController.clear();
            lonController.clear();
            descriptionController.clear();
          },
          child: Container(
              child: Text(
            "Отмена",
            style: TextStyleSet()
                .textMedium16
                .copyWith(color: Theme.of(context).hintColor),
          )),
        ),
        leadingWidth: 90,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Не выбрано",
                        style: TextStyleSet()
                            .textRegular16
                            .copyWith(color: Theme.of(context).hintColor),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Delimer(),
                ),
                Text(
                  "НАЗВАНИЕ",
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    autofocus: true,
                    focusNode: nameNode,
                    decoration: InputDecoration(
                      hintText: 'название',
                    ),
                    controller: nameController,
                    onSubmitted: (value) => latNode.requestFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ШИРОТА",
                              style: TextStyleSet().textRegular.copyWith(
                                  color:
                                      Theme.of(context).unselectedWidgetColor),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 8, 0),
                              child: TextField(
                                controller: latController,
                                decoration: InputDecoration(
                                  hintText: 'широта',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.cancel_rounded),
                                    onPressed: () => latController.clear(),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                focusNode: latNode,
                                onSubmitted: (value) => lonNode.requestFocus(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ДОЛГОТА",
                                style: TextStyleSet().textRegular.copyWith(
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: TextField(
                                  controller: lonController,
                                  focusNode: lonNode,
                                  onSubmitted: (value) =>
                                      descriptionNode.requestFocus(),
                                  decoration: InputDecoration(
                                    hintText: 'долгота',
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.cancel_rounded),
                                      onPressed: () => lonController.clear(),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 25),
                  child: Text(
                    "Указать на карте",
                    style: TextStyleSet()
                        .textMedium16
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "ОПИСАНИЕ",
                    style: TextStyleSet().textRegular.copyWith(
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  focusNode: descriptionNode,
                  onSubmitted: (value) => descriptionNode.unfocus(),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "введите текст",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  /// Сохранение нового места
                  newSight.name = nameController.text;
                  newSight.lat = double.parse(latController.text);
                  newSight.lon = double.parse(lonController.text);
                  newSight.details = descriptionController.text;
                  mocks.add(newSight);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "СОЗДАТЬ",
                    style: TextStyleSet()
                        .textBold
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
