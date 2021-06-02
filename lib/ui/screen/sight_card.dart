import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/repository/NetworkExeption.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/widgets/image_network.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/screen/visiting.dart';

import '../res/text_styles.dart';

class SightCard extends StatefulWidget {
  final int id;
  const SightCard(this.id, {Key key}) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  int _curentImage = 0;

  bool _inWont = false;

  Place _place;

  void _getPlace() async {
    try {
      Place place = await PlaceInteractor().getPlaceDetails(widget.id);
      setState(() {
        _place = place;
      });
    } on NetworkExeption catch (e) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return SmthError();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_place == null)
          ? Builder(
              builder: (BuildContext context) {
                _getPlace();
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 360,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: _place.urls.length,
                            onPageChanged: (value) {
                              setState(() {
                                _curentImage = value;
                              });
                            },
                            itemBuilder: (context, index) {
                              final item = _place.urls[index];
                              return Container(
                                width: double.infinity,
                                child: ImageNetwork(item, fit: BoxFit.cover),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 8,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  for (var i = 0; i < _place.urls.length; i++)
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _curentImage == i
                                              ? Theme.of(context).primaryColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.clear_rounded,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _place.name,
                          style: TextStyleSet()
                              .textBold24
                              .copyWith(color: Theme.of(context).primaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              Text(
                                _place.placeTypeName,
                                style: TextStyleSet().textBold.copyWith(
                                    color: Theme.of(context).hintColor),
                                maxLines: 1,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "закрыто до 09:00",
                                    style: TextStyleSet().textRegular.copyWith(
                                          color: Theme.of(context)
                                              .unselectedWidgetColor,
                                        ),
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            _place.description,
                            style: TextStyleSet().textRegular.copyWith(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: ElevatedButton(
                            onPressed: () {
                              print("Построить маршрут");
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: SvgPicture.asset(
                                          ImagesPaths.buildRoute),
                                    ),
                                    Text(
                                      "ПОСТРОИТЬ МАРШРУТ",
                                      style: TextStyleSet().textBold.copyWith(
                                          color: Theme.of(context).canvasColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          width: double.infinity,
                          height: 1.6,
                          color: Theme.of(context)
                              .unselectedWidgetColor
                              .withOpacity(0.24),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: TextButton(
                                    onPressed: () async {
                                      var res = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(Duration(days: 90)),
                                      );
                                      print(res);
                                      // if (res != null) {
                                      //   mocks[mocks.indexOf(_place)].wontDate =
                                      //       res;
                                      //   setState(() {
                                      //     _inWont = mocks[mocks.indexOf(_place)].wontVisit;
                                      //   });
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: SvgPicture.asset(
                                            ImagesPaths.toPlan,
                                            color: _inWont
                                                ? Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.56)
                                                : Theme.of(context)
                                                    .primaryColor,
                                          ),
                                        ),
                                        Text(
                                          'Запланировать',
                                          style: TextStyleSet()
                                              .textRegular
                                              .copyWith(
                                                color: _inWont
                                                    ? Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.56)
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    context
                                        .read<VisitingState>()
                                        .setWont(_place, DateTime.now());
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: SvgPicture.asset(
                                            ImagesPaths.favorite,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          )),
                                      Text(
                                        'В Избранное',
                                        style:
                                            TextStyleSet().textRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                      ),
                                    ],
                                  ),
                                )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
