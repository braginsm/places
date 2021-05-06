import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/widgets/image_network.dart';

import '../res/text_styles.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  const SightCard(this.sight, {Key key}) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  int _curentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                      itemCount: widget.sight.url.length,
                      onPageChanged: (value) {
                        setState(() {
                          _curentImage = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        final item = widget.sight.url[index];
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
                            for (var i = 0; i < widget.sight.url.length; i++)
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _curentImage == i
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
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
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
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
                    widget.sight.name,
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
                          widget.sight.type,
                          style: TextStyleSet()
                              .textBold
                              .copyWith(color: Theme.of(context).hintColor),
                          maxLines: 1,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "закрыто до 09:00",
                              style: TextStyleSet().textRegular.copyWith(
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                  ),
                              maxLines: 1,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      widget.sight.details,
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
                                child: SvgPicture.asset(ImagesPaths.buildRoute),
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
                              onPressed: () {
                                print("Запланировать");
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SvgPicture.asset(ImagesPaths.toPlan),
                                  ),
                                  Text(
                                    'Запланировать',
                                    style: TextStyleSet().textRegular.copyWith(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.56)),
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
                              print("В избранное");
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
                                  style: TextStyleSet().textRegular.copyWith(
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
