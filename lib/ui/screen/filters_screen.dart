import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

import '../../mocks.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _radius = RangeValues(100, 10000);

  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  /// текущие координаты 56.84987946580704, 53.247889685270756
  final double lat = 56.84987946580704;
  final double lon = 53.247889685270756;

  /// отфильтрованный список мест
  List<Sight> sights = mocks;

  /// подписи фильтров
  final List<String> titles = [
    "Отель",
    "Ресторан",
    "Особое место",
    "Парк",
    "Музей",
    "Кафе"
  ];

  /// хранение значений фильтров
  List<bool> filterValues = [];

  ///Определяет, попадает ли достопримечательность в выбанный радиус
  bool _inDistans(Sight sight) {
    final double _distans = sight.getDistans(lat, lon);
    return _radius.start <= _distans && _radius.end >= _distans;
  }

  /// возвращает список достопримечательностей отфильтрованный по выбранному радиусу
  List<Sight> filterByRadius() => mocks.where((f) => _inDistans(f)).toList();

  @override
  void initState() {
    super.initState();

    /// начальные значения
    sights = filterByRadius();
    filterValues = List.generate(titles.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    const double _maxRadius = 10000;
    const double _minRadius = 100;

    /// сетка "таблицы" фильтров
    final lineCnt = 2;
    final colCnt = 3;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 15,
          ),
          onPressed: () {
            print("Back");
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              print("Очистить");
              setState(() {
                filterValues = List.generate(titles.length, (index) => false);
                _radius = RangeValues(_minRadius, _maxRadius);
                sights = filterByRadius();
              });
            },
            child: Text(
              "Очистить",
              style: TextStyleSet()
                  .textMedium16
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < lineCnt; i++)
                      Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var j = colCnt * i; j < colCnt * (i + 1); j++)
                              Expanded(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        IconButton(
                                          iconSize: 64,
                                          icon: SvgPicture.asset(
                                            "res/images/tick_$j.svg",
                                          ),
                                          onPressed: () {
                                            print(titles[j]);
                                            setState(() {
                                              filterValues[j] =
                                                  !filterValues[j];
                                            });
                                          },
                                        ),
                                        if (filterValues[j])
                                          Positioned(
                                            child: SvgPicture.asset(
                                              "res/images/tick_choice.svg",
                                            ),
                                            bottom: 0,
                                            right: 0,
                                          )
                                      ],
                                    ),
                                    Text(titles[j])
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ]),
                  ],
                ),
              ),
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
                min: _minRadius,
                max: _maxRadius,
                divisions: _maxRadius.round(),
                onChanged: (RangeValues values) {
                  setState(() {
                    _radius = values;
                    sights = filterByRadius();
                    print(sights
                        .length); // вывожу в консоль кол-во достопримечательностей после фильтрации
                  });
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                print("Показать");
              },
              child: Text(
                "ПОКАЗАТЬ (${sights.length})",
                style: TextStyleSet().textBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
