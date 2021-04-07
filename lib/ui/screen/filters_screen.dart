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
  RangeValues _radius = const RangeValues(100, 10000);

  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  /// текущие координаты 56.84987946580704, 53.247889685270756
  final double lat = 56.84987946580704;
  final double lon = 53.247889685270756;

  /// отфильтрованный список мест
  List<Sight> sights = mocks;

  List<bool> filterValues = List.generate(TickType.values.length, (index) => false);

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
    sights = filterByRadius();
  }

  @override
  Widget build(BuildContext context) {
    const _maxRadius = 10000;
    const _minRadius = 100;

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
                margin: EdgeInsets.fromLTRB(16, 24, 16, 56),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FIlterItem(
                          type: TickType.hotel,
                        ),
                        FIlterItem(
                          type: TickType.restourant,
                        ),
                        FIlterItem(
                          type: TickType.particular,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FIlterItem(
                          type: TickType.park,
                        ),
                        FIlterItem(
                          type: TickType.museum,
                        ),
                        FIlterItem(
                          type: TickType.cafe,
                        ),
                      ],
                    ),
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
                min: _minRadius.ceilToDouble(),
                max: _maxRadius.ceilToDouble(),
                divisions: _maxRadius,
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

class FIlterItem extends StatelessWidget {
  bool checked = false;
  TickType type = TickType.cafe;

  final List<String> titles = [
    "Отель",
    "Ресторан",
    "Особое место",
    "Парк",
    "Музей",
    "Кафе"
  ];

  FIlterItem({Key key, this.type, this.checked = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              IconButton(
                iconSize: 64,
                icon: SvgPicture.asset(
                  "res/images/tick_${type.index}.svg",
                ),
                onPressed: () {
                  print(titles[type.index]);
                },
              ),
              if (checked)
                Positioned(
                  child: SvgPicture.asset(
                    "res/images/tick_choice.svg",
                  ),
                  bottom: 0,
                  right: 0,
                )
            ],
          ),
          Text(titles[type.index])
        ],
      ),
    );
  }
}

enum TickType { hotel, restourant, particular, park, museum, cafe }
