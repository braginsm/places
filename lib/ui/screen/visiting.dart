import 'package:flutter/material.dart';
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
          backgroundColor: Theme.of(context).canvasColor,
          shadowColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "Избранное",
                style: TextStyleSet().textMedium18.copyWith(color: Color(0xff252849)),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 52),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                tabs: [Tab(text: "Хочу посетить"), Tab(text: "Посетил")],
                unselectedLabelColor: Color(0xff7C7E92).withOpacity(0.56),
                labelColor: Colors.white,
                unselectedLabelStyle: TextStyleSet().textBold,
                labelStyle: TextStyleSet().textBold,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40),
                  color: Color(0xff3B3E5B),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            wontList.length > 0
                ? Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                        children: [for (var item in wontList) VisitItem(item)]))
                : Center(
                    child: Column(children: [
                      Container(
                        width: 64,
                        height: 64,
                        color: Color(0xff7C7E92).withOpacity(0.56),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: Text("Пусто",
                            style: TextStyleSet().textMedium18.copyWith(
                                color: Color(0xff7C7E92).withOpacity(0.56))),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 53, vertical: 8),
                        child: Text(
                          "Отмечайте понравившиеся места и они появиятся здесь.",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyleSet().textRegular.copyWith(
                              color: Color(0xff7C7E92).withOpacity(0.56)),
                        ),
                      ),
                    ]),
                  ),
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                  children: [for (var item in visitList) VisitItem(item)]),
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
                  style: TextStyleSet().textRegular.copyWith(color: Colors.white),
                ),
              ),
              Positioned(
                top: 18,
                right: 18,
                child: Container(
                  // Контейнер кнопки сердечка
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
              ),
              Positioned(
                top: 18,
                right: 56,
                child: Container(
                  // Контейнер кнопки сердечка
                  color: Colors.white,
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
              color: Color(0xfff5f5f5),
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
                  style: TextStyleSet().textMedium16.copyWith(color: Color(0xff3B3E5B)),
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
                      color: Color(sight.wontVisit ? 0xff4CAF50 : 0xff7C7E92)),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                child: Text(
                  "закрыто до 09:00",
                  style: TextStyleSet().textRegular.copyWith(color: Color(0xff7C7E92)),
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
