import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';

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
            style: TextStyleSet().textBold32.copyWith(color: ColorsLightSet.main),
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
                      loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ? 
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                      },
                    ),
                  )
                ),
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
              ],
            )),
        Container(
            width: double.infinity,
            height: 92,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: ColorsLightSet.grey,
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
                  style: TextStyleSet().textMedium16.copyWith(color: Theme.of(context).secondaryHeaderColor),
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
                  style: TextStyleSet().textRegular16.copyWith(color: ColorsLightSet.secondary2),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ])),
      ]),
    );
  }
}
