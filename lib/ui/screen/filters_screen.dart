import 'package:flutter/material.dart';
import 'package:places/ui/res/text_styles.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _radius = const RangeValues(100, 10000);

  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    const _maxRadius = 10000;
    const _minRadius = 100;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Расстояние",
                  style: TextStyleSet().textRegular16,
                ),
                Text(
                  "от ${_getKm(_radius.start)} до ${_getKm(_radius.end)} км",
                  style: TextStyleSet()
                      .textRegular16
                      .copyWith(color: Theme.of(context).hintColor),
                )
              ],
            ),
          ),
          RangeSlider(
            values: _radius,
            min: _minRadius.ceilToDouble(),
            max: _maxRadius.ceilToDouble(),
            divisions: _maxRadius,
            onChanged: (RangeValues values) {
              setState(() {
                _radius = values;
              });
            },
          ),
        ],
      ),
    );
  }
}
