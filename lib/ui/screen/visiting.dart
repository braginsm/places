import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

class VisitingScreen extends StatefulWidget {
  VisitingScreen({Key key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
                style: textMedium18.copyWith(color: Color(0xff252849)),
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
                tabs: [
                  Tab(text: "Хочу посетить"),
                  Tab(text: "Посетил")
                ],
                unselectedLabelColor: Color(0xff7C7E92).withOpacity(0.56),
                labelColor: Colors.white,
                unselectedLabelStyle: textBold,
                labelStyle: textBold,
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
            Text("0"),
            Text("1"),
          ],
        ),
      ),
    );
  }
}
