import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

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
            onTap: () => print("Поиск"),
          ),
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
                SightListItem(mocks[0]),
                SightListItem(mocks[1]),
                SightListItem(mocks[2]),
              ]),
            ),
            Positioned(
              bottom: 16,
              child: InkWell(
                onTap: () => print("Добавить новое место"),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).tabBarTheme.labelColor,
                        ),
                        Text(
                          " НОВОЕ МЕСТО",
                          style: TextStyleSet().textBold.copyWith(color: Theme.of(context).tabBarTheme.labelColor),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(colors: [Theme.of(context).indicatorColor, Theme.of(context).accentColor]),
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

class SightListItem extends StatelessWidget {
  final Sight sight;
  const SightListItem(this.sight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 96,
                      child: Image.network(
                        sight.url,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        sight.type,
                        style: TextStyleSet()
                            .textRegular
                            .copyWith(color: Theme.of(context).canvasColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: Text(
                        sight.name,
                        style: TextStyleSet().textMedium16.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      width: double.infinity,
                      height: 18,
                      child: Text(
                        sight.details,
                        style: TextStyleSet()
                            .textRegular16
                            .copyWith(color: Theme.of(context).hintColor),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Theme.of(context).hintColor.withOpacity(0.56),
              highlightColor: Colors.transparent,
              onTap: () => print("tap card"),
              child: Container(
                width: double.infinity,
                height: 188,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                print("В избранное");
              },
              icon: SvgPicture.asset(
                ImagesPaths.favorite,
                color: Theme.of(context).canvasColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
