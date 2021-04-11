import 'package:flutter/material.dart';

class Delimer extends StatelessWidget {
  /// Разделитель элементов списка
  const Delimer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8,
      width: double.infinity,
      color: Theme.of(context).unselectedWidgetColor.withOpacity(0.056),
    );
  }
}