import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/visiting.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key key}) : super(key: key);

  final List<Widget> _navScreens = [
    SightListScreen(),
    VisitingScreen(),
    SettingsScreen()
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
            icon: Icon(Icons.list_alt_rounded),
            label: 'Список',
          ),
          // Раскомментировать когда будет экран с картой
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.map_outlined),
          //   label: 'Карта',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesPaths.heart),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Натройки',
          ),
        ],
      ),
    );
  }
}
