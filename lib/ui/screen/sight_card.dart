import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        )
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              sight.name,
              style: TextStyleSet().textBold24.copyWith(color: Theme.of(context).primaryColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Text(
                    sight.type,
                    style: TextStyleSet().textBold.copyWith(color: Theme.of(context).hintColor),
                    maxLines: 1,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        "закрыто до 09:00",
                        style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).unselectedWidgetColor,),
                        maxLines: 1,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                sight.details,
                style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "ПОСТРОИТЬ МАРШРУТ",
                  style: TextStyleSet().textBold.copyWith(color: Theme.of(context).canvasColor),
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
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Запланировать',
                          style: TextStyleSet().textRegular.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.56)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: Center(
                          child: Text(
                        'В Избранное',
                        style: TextStyleSet().textRegular.copyWith(color: Theme.of(context).secondaryHeaderColor, 
                        ),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
