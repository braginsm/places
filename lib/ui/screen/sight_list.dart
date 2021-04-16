import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/image_network.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';

import '../res/text_styles.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Список интересных мест"),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          child: SearchBar(
              readOnly: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SightSearchScreen()));
              }),
          preferredSize: Size(double.infinity, 64),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                for (var item in mocks) SightItem(item, actions: [
                  IconButton(
                    onPressed: () {
                      print("В избранное");
                    },
                    icon: SvgPicture.asset(
                      ImagesPaths.favorite,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ],),
              ]),
            ),
            Positioned(
              bottom: 16,
              child: InkWell(
                onTap: () => print("Добавить новое место"),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).tabBarTheme.labelColor,
                        ),
                        Text(
                          " НОВОЕ МЕСТО",
                          style: TextStyleSet().textBold.copyWith(
                              color: Theme.of(context).tabBarTheme.labelColor),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).indicatorColor,
                      Theme.of(context).accentColor
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
