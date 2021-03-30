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
                onTap: (index) {
                // Tab index when user select it, it start from zero
                },
                tabs: [
                  Container(
                    child: Center(child: Text("0"),),
                    height: 40,
                    width: 164,
                    decoration: BoxDecoration(
                      color: Color(0xff3B3E5B),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Container(
                    child: Center(child: Text("1"),),
                    height: 40,
                    width: 164,
                    decoration: BoxDecoration(
                      color: Color(0xff3B3E5B),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ],
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