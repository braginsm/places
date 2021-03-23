import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  const SightCard(Sight sight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 360,
        leading: Container(
          padding: EdgeInsets.fromLTRB(16, 36, 0, 292),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 15,),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}