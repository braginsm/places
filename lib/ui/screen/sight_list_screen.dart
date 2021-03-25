import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

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
        backgroundColor: Theme.of(context).canvasColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 152, //высота аппбара в пикелях из фигмы
        title: Container(
          padding: EdgeInsets.fromLTRB(16, 64, 16, 16),
          child: Text(
            "Список интересных мест",
            style: textBold32.copyWith(color: Color(0xff252849)),
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(children: [
          SightListItem(mocks[0]),
          SightListItem(mocks[1]),
          SightListItem(mocks[2]),
        ]),
      ),
    );
  }
}

class SightListItem extends StatelessWidget {

  final Sight sight;
  const SightListItem(this.sight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 188,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(children: [
        Container(
            width: double.infinity,
            height: 96,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            child: Stack(
              children: [
                Container(), //контейнер для превью места
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16),
                  child: Text(
                    sight.type,
                    style: textRegular.copyWith(color: Colors.white),
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
              ],
            )),
        Container(
            width: double.infinity,
            height: 92,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 40,
                child: Text(
                  sight.name,
                  style: textMedium16.copyWith(color: Color(0xff3B3E5B)),
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
                  style: textRegular16.copyWith(color: Color(0xff7C7E92)),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ])),
      ]),
    );
  }
}
