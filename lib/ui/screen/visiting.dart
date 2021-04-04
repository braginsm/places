import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/widget/empty_list.dart';
import '../res/text_styles.dart';
import '../../mocks.dart';
import '../widget/bottom_navigation.dart';
import '../../domain/sight.dart';

class VisitingScreen extends StatefulWidget {
  VisitingScreen({Key key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final wontList = mocks.where((f) => f.wontVisit);
  final visitList = mocks.where((f) => f.visit);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "Избранное",
                style: TextStyleSet().textMedium18.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 52),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                tabs: [Tab(text: "Хочу посетить"), Tab(text: "Посетил")],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: wontList.length > 0
                ? Column(
                  children: [for (var item in wontList) VisitItem(item)]
                )
                : EmptyListWont(),
            ),
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: visitList.length > 0
                ? Column(
                  children: [for (var item in visitList) VisitItem(item)])
                : EmptyListVisited(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class VisitItem extends StatelessWidget {
  final Sight sight;
  const VisitItem(this.sight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(children: [
        Container(
          child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
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
                  )),
              Container(
                margin: EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  sight.type,
                  style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).canvasColor),
                ),
              ),
              Positioned(
                top: 18,
                right: 18,
                child: Container(
                  // Контейнер кнопки сердечка
                  color: Theme.of(context).canvasColor,
                  width: 20,
                  height: 20,
                ),
              ),
              Positioned(
                top: 18,
                right: 56,
                child: Container(
                  // Контейнер кнопки сердечка
                  color: Theme.of(context).canvasColor,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 102,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  sight.name,
                  style: TextStyleSet().textMedium16.copyWith(color: Theme.of(context).secondaryHeaderColor),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                height: 28,
                child: Text(
                  sight.wontVisit
                      ? "Запланировано на 12 окт. 2020"
                      : "Цель достигнута 12 окт. 2020",
                  style: TextStyleSet().textRegular.copyWith(
                      color: sight.wontVisit ? Theme.of(context).accentColor : Theme.of(context).hintColor,),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                child: Text(
                  "закрыто до 09:00",
                  style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).hintColor),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
