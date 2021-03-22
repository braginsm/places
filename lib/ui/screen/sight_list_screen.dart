import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).canvasColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 458, //высота аппбара в пикелях из фигмы
        title: Container(
          padding: EdgeInsets.fromLTRB(16, 64, 16, 322),
          child: Text("Список интересных мест",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff252849),
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
            maxLines: 2,
          ),
        ),
      ),
      body: Container(
        child: Text("Scaffold body text"),
      ),
    );
  }
}