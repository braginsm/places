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
                  color: Colors.amber,
                ),
                Positioned(
                  top: 36,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
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
              style: textBold24.copyWith(color: Color(0xff3B3E5B)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Text(
                    sight.type,
                    style: textBold.copyWith(color: Color(0xff3B3E5B)),
                    maxLines: 1,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        "закрыто до 09:00",
                        style: textRegular.copyWith(color: Color(0xff7C7E92)),
                        maxLines: 1,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                sight.details,
                style: textRegular.copyWith(color: Color(0xff3B3E5B)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff4CAF50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "ПОСТРОИТЬ МАРШРУТ",
                  style: textBold.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              width: double.infinity,
              height: 1.6,
              color: Color.fromARGB(142, 124, 126, 146).withOpacity(0.24),
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
                          style: textRegular.copyWith(
                            color: Color(0xff7C7E92).withOpacity(0.56)
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
                        style: textRegular.copyWith(color: Color(0xff3B3E5B) 
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
