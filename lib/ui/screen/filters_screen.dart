import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

import '../../mocks.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _radius = const RangeValues(100, 10000);

  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  /// текущие координаты 56.84987946580704, 53.247889685270756
  final double lat = 56.84987946580704;
  final double lon = 53.247889685270756;

  /// отфильтрованный список мест
  List<Sight> sights = mocks;

  ///Определяет, попадает ли достопримечательность в выбанный радиус
  bool _inDistans(Sight sight) {
    final double _distans = sight.getDistans(lat, lon);
    return _radius.start <= _distans && _radius.end >= _distans;
  }

  /// возвращает список достопримечательностей отфильтрованный по выбранному радиусу
  List<Sight> filterByRadius() =>
      mocks.where((f) => _inDistans(f)).toList();

  @override
  void initState() {
    super.initState();
    sights = filterByRadius();
  }

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
                sights = filterByRadius();
                print(sights.length); // вывожу в консоль кол-во достопримечательностей после фильтрации
              });
            },
          ),
        ],
      ),
    );
  }
}
