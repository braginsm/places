import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocks/filters/filters_bloc.dart';
import 'package:places/data/blocks/filters/filters_event.dart';
import 'package:places/data/blocks/filters/filters_state.dart';
import 'package:places/data/interactor/user_property_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/search_place.dart';
import 'package:places/ui/screen/widgets/preloader.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String _getKm(double value) => (value / 1000).toStringAsFixed(1);

  late FiltersBloc _bloc;

  @override
  void initState() {
    _bloc = FiltersBloc(context.read<UserPropertyInteractor>())
      ..add(FiltersLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// сетка "таблицы" фильтров
    final bool oneLine = MediaQuery.of(context).size.height <= 800;
    final int lineCnt = oneLine ? 1 : 2;
    final int colCnt = lineCnt > 1 ? 3 : PlaceType.values.length;

    return BlocProvider<FiltersBloc>(
      create: (context) => _bloc,
      child: Scaffold(
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
              onPressed: () => _bloc.add(FiltersCleanEvent()),
              child: Text(
                "Очистить",
                style: TextStyleSet()
                    .textMedium16
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            )
          ],
        ),
        body: BlocBuilder<FiltersBloc, FiltersState>(
          builder: (BuildContext context, state) {
            if (state is FiltersLoadingInProgressState) {
              return const PreloaderWidget();
            }
            if (state is FiltersLoadingSuccessState) {
              const double _minRadius = 0;
              const double _maxRadius = 10000;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text(
                          "КАТЕГОРИИ",
                          style: TextStyleSet().textRegular.copyWith(
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                      if (oneLine)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FiltersWidget(
                            colCnt: colCnt,
                            lineCnt: lineCnt,
                            filtersBloc: _bloc,
                          ),
                        )
                      else
                        FiltersWidget(
                          colCnt: colCnt,
                          lineCnt: lineCnt,
                          filtersBloc: _bloc,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Расстояние",
                              style: TextStyleSet().textRegular16.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "от ${_getKm(state.minRadius)} до ${_getKm(state.maxRadius)} км",
                              style: TextStyleSet()
                                  .textRegular16
                                  .copyWith(color: Theme.of(context).hintColor),
                            )
                          ],
                        ),
                      ),
                      RangeSlider(
                        values: RangeValues(state.minRadius, state.maxRadius),
                        min: _minRadius,
                        max: _maxRadius,
                        divisions: _maxRadius.round(),
                        onChanged: (RangeValues values) => _bloc.add(
                            FiltersRadiusChangeEvent(values.start, values.end)),
                      ),
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SearchPlaceScreen()));
                      },
                      child: Text(
                        //"ПОКАЗАТЬ (${context.watch<SerachInteractor>().searchResult.length})",
                        "ПОКАЗАТЬ",
                        style: TextStyleSet().textBold,
                      ),
                    ),
                  ),
                ],
              );
            }
            throw ArgumentError(
                "Не предусмотренное состояние в _FiltersScreenState");
          },
        ),
      ),
    );
  }
}

class FiltersWidget extends StatelessWidget {
  final int lineCnt;
  final FiltersBloc filtersBloc;
  final int colCnt;

  const FiltersWidget(
      {Key? key,
      required this.lineCnt,
      required this.colCnt,
      required this.filtersBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < lineCnt; i++)
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var j = colCnt * i; j < colCnt * (i + 1); j++)
                    if (lineCnt > 1)
                      Expanded(
                        child: FilterItemWidget(
                          index: j,
                          filtersBloc: filtersBloc,
                        ),
                      )
                    else
                      FilterItemWidget(
                        index: j,
                        filtersBloc: filtersBloc,
                      ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ]),
        ],
      ),
    );
  }
}

class FilterItemWidget extends StatelessWidget {
  final int index;
  final FiltersBloc filtersBloc;
  const FilterItemWidget({
    Key? key,
    required this.filtersBloc,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool checked =
        (filtersBloc.state as FiltersLoadingSuccessState).categorys[index];
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                iconSize: 64,
                icon: SvgPicture.asset(ImagesPaths.ticks[index]),
                onPressed: () => filtersBloc
                    .add(FiltersCategoryChangeEvent(index, !checked)),
              ),
            ),
            if (checked)
              Positioned(
                child: SvgPicture.asset(ImagesPaths.tickChoice),
                bottom: 0,
                right: 0,
              )
          ],
        ),
        Text(
          Place.ruPlaceTypeNames[index],
          style: TextStyleSet()
              .textRegular12
              .copyWith(color: Theme.of(context).primaryColor),
          maxLines: 1,
        )
      ],
    );
  }
}
