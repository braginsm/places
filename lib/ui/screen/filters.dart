import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import './sight_search.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({Key key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  /// подписи фильтров
  final List<String> titles = [
    "Отель",
    "Ресторан",
    "Особое место",
    "Парк",
    "Музей",
    "Кафе"
  ];

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
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<SightSearchState>().cleanFilter();
              context
                  .read<SightSearchState>()
                  .radiusSet(RangeValues(_minRadius, _maxRadius));
              context.read<SightSearchState>().filterByRadius();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16,),
                child: Text(
                  "КАТЕГОРИИ",
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                              ImagesPaths.ticks[j]),
                                          onPressed: () {
                                            context
                                                .read<SightSearchState>()
                                                .changeFilter(j);
                                          },
                                        ),
                                        if (context
                                            .watch<SightSearchState>()
                                            .filterValues[j])
                                          Positioned(
                                            child: SvgPicture.asset(
                                                ImagesPaths.tickChoice),
                                            bottom: 0,
                                            right: 0,
                                          )
                                      ],
                                    ),
                                    Text(
                                      titles[j],
                                      style: TextStyleSet()
                                          .textRegular12
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    )
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
                      style: TextStyleSet()
                          .textRegular16
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      "от ${_getKm(context.watch<SightSearchState>().radius.start)} до ${_getKm(context.watch<SightSearchState>().radius.end)} км",
                      style: TextStyleSet()
                          .textRegular16
                          .copyWith(color: Theme.of(context).hintColor),
                    )
                  ],
                ),
              ),
              RangeSlider(
                values: context.watch<SightSearchState>().radius,
                min: _minRadius,
                max: _maxRadius,
                divisions: _maxRadius.round(),
                onChanged: (RangeValues values) {
                  context.read<SightSearchState>().radiusSet(values);
                  context.read<SightSearchState>().filterByRadius();
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SightSearchScreen()));
              },
              child: Text(
                "ПОКАЗАТЬ (${context.watch<SightSearchState>().searchResult.length})",
                style: TextStyleSet().textBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
