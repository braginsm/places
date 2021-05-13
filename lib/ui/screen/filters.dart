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

  @override
  Widget build(BuildContext context) {
    const double _maxRadius = 10000;
    const double _minRadius = 100;

    /// сетка "таблицы" фильтров
    final bool oneLine = MediaQuery.of(context).size.height <= 800;
    final int lineCnt = oneLine ? 1 : 2;
    final int colCnt = lineCnt > 1 ? 3 : context.watch<SightSearchState>().titles.length;

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
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  "КАТЕГОРИИ",
                  style: TextStyleSet()
                      .textRegular
                      .copyWith(color: Theme.of(context).unselectedWidgetColor),
                ),
              ),
              if (oneLine) SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FiltersWidget(
                  colCnt: colCnt, 
                  lineCnt: lineCnt, 
                ),
              ) else FiltersWidget(
                colCnt: colCnt, 
                lineCnt: lineCnt, 
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => SightSearchScreen()));
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

class FiltersWidget extends StatelessWidget {
  final int lineCnt;

  final int colCnt;

  const FiltersWidget({Key key, @required this.lineCnt, @required this.colCnt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    if (lineCnt > 1) Expanded(
                      child: FilterItemWidget(text: context.watch<SightSearchState>().titles[j], path: ImagesPaths.ticks[j],),
                    ) else FilterItemWidget(text: context.watch<SightSearchState>().titles[j], path: ImagesPaths.ticks[j],),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ]),
        ],
      ),
    );
  }
}

class FilterItemWidget extends StatelessWidget {
  final String text;
  final String path;
  const FilterItemWidget({Key key, this.text, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                iconSize: 64,
                icon: SvgPicture.asset(path),
                onPressed: () {
                  context
                      .read<SightSearchState>()
                      .changeFilter(text);
                },
              ),
            ),
            if (context
                .watch<SightSearchState>()
                .filterValue(text))
              Positioned(
                child:
                    SvgPicture.asset(ImagesPaths.tickChoice),
                bottom: 0,
                right: 0,
              )
          ],
        ),
        Text(
          text,
          style: TextStyleSet().textRegular12.copyWith(
              color: Theme.of(context).primaryColor),
          maxLines: 1,
        )
      ],
    );
  }
}