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
          child: RichText(
            text: TextSpan(
              text: "", 
              children: [ //не нашел способа стилизации только первого символа TextSpan по этому разделил на подстроки, для их стилизации
                TextSpan(
                  text: "С",
                  style: TextStyle(
                    color: Color(0xff4CAF50)
                  )
                ),
                TextSpan(
                  text: "писок "
                ),
                TextSpan(
                  text: "и",
                  style: TextStyle(
                    color: Color(0xfffcdd3d)
                  )
                ),
                TextSpan(
                  text: "нтересных мест"
                ),
              ],
              style: TextStyle(
                color: Color(0xff252849),
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            textAlign: TextAlign.left,
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