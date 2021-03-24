import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

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
            style: TextStyle(
                color: Color(0xff252849),
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: "Roboto"),
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
  Sight _sight = Sight();

  SightListItem(Sight sight) {
    _sight = sight;
  }

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
                    _sight.type,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight
                            .w700, //толщину шрифта беру из фигмы, но выглядит он тоньше
                        fontSize: 14,
                        fontFamily: "Roboto"),
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
                  _sight.name,
                  style: TextStyle(
                      color: Color(0xff3B3E5B),
                      fontWeight: FontWeight
                          .w500, //толщину шрифта беру из фигмы, но выглядит он тоньше
                      fontSize: 16,
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                height: 18,
                child: Text(
                  _sight.details,
                  style: TextStyle(
                      color: Color(0xff7C7E92),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ])),
      ]),
    );
  }
}
