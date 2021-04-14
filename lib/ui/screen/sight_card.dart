import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/images.dart';

import '../res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard(this.sight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 360),
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
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
                  Positioned(
                      top: 36,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                sight.name,
                style: TextStyleSet()
                    .textBold24
                    .copyWith(color: Theme.of(context).primaryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Text(
                      sight.type,
                      style: TextStyleSet()
                          .textBold
                          .copyWith(color: Theme.of(context).hintColor),
                      maxLines: 1,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          "закрыто до 09:00",
                          style: TextStyleSet().textRegular.copyWith(
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                          maxLines: 1,
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  sight.details,
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () {
                    print("Построить маршрут");
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SvgPicture.asset(ImagesPaths.buildRoute),
                          ),
                          Text(
                            "ПОСТРОИТЬ МАРШРУТ",
                            style: TextStyleSet()
                                .textBold
                                .copyWith(color: Theme.of(context).canvasColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                width: double.infinity,
                height: 1.6,
                color: Theme.of(context).unselectedWidgetColor.withOpacity(0.24),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            print("Запланировать");
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(ImagesPaths.toPlan),
                              ),
                              Text(
                                'Запланировать',
                                style: TextStyleSet().textRegular.copyWith(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.56)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: TextButton(
                        onPressed: () {
                          print("В избранное");
                        },
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  ImagesPaths.favorite,
                                  color: Theme.of(context).secondaryHeaderColor,
                                )),
                            Text(
                              'В Избранное',
                              style: TextStyleSet().textRegular.copyWith(
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                            ),
                          ],
                        ),
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
