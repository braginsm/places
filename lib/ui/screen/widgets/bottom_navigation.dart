import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/map.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/visiting.dart';

class BottomNavigation extends StatelessWidget {
  final int? activeIndex;
  BottomNavigation({Key? key, this.activeIndex}) : super(key: key);

  final List<Widget> _navScreens = [
    SightListScreen(),
    const MapScreen(),
    const VisitingScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.8,
            color: Theme.of(context).hintColor.withOpacity(0.56),
          ),
        ),
      ),
      child: BottomNavigationBar(
        onTap: (value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => _navScreens[value]));
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesPaths.list),
            label: 'Список',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesPaths.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImagesPaths.heart,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesPaths.settings),
            label: 'Натройки',
          ),
        ],
      ),
    );
  }
}
