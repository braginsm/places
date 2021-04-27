import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_item.dart';

import '../res/text_styles.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Список интересных мест",
                  maxLines: 2,
                ),
                centerTitle: true,
                titlePadding: EdgeInsets.all(16),
              ),
            ),
            SliverToBoxAdapter(
              child: PreferredSize(
                preferredSize: Size(double.infinity, 64),
                child: SearchBar(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SightSearchScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = mocks[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SightItem(
                      item,
                      actions: [
                        IconButton(
                          onPressed: () {
                            print("В избранное");
                          },
                          icon: SvgPicture.asset(
                            ImagesPaths.favorite,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: mocks.length,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Stack(
            //     alignment: AlignmentDirectional.bottomCenter,
            //     children: [
            //       ListView.builder(
            //           itemCount: mocks.length,
            //           itemBuilder: (context, index) {
                        
            //           }),
            //       Positioned(
            //         bottom: 16,
            //         child: InkWell(
            //           onTap: () => Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => AddSightScreen())),
            //           child: Container(
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 12, horizontal: 16),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.add,
            //                     color: Theme.of(context).tabBarTheme.labelColor,
            //                   ),
            //                   Text(
            //                     " НОВОЕ МЕСТО",
            //                     style: TextStyleSet().textBold.copyWith(
            //                         color: Theme.of(context).tabBarTheme.labelColor),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(24),
            //               gradient: LinearGradient(colors: [
            //                 Theme.of(context).indicatorColor,
            //                 Theme.of(context).accentColor
            //               ]),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
