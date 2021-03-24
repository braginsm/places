import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  Sight _sight;

  SightCard(Sight sight) {
    _sight = sight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( 
        preferredSize: Size(double.infinity, 360),
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
      ),
      body: Container(
        margin: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_sight.name,
              style: TextStyle(
                color: Color(0xff3B3E5B),
                fontFamily: "Roboto",
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                children: [
                  Text(_sight.type,
                    style: TextStyle(
                      color: Color(0xff3B3E5B),
                      fontFamily: "Roboto",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "закрыто до 09:00",
                      style: TextStyle(
                        color: Color(0xff7C7E92),
                        fontFamily: "Roboto",
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                      maxLines: 1,
                    )
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                _sight.details,
                style: TextStyle(
                  color: Color(0xff3B3E5B),
                  fontFamily: "Roboto",
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.03
                  ),
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
                          style: TextStyle(
                            color: Color(0xff7C7E92).withOpacity(0.56),
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'В Избранное',
                          style: TextStyle(
                            color: Color(0xff3B3E5B),
                            fontFamily: "Roboto",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ),
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
