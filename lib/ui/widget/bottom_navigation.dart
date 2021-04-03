import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.8, color: Theme.of(context).hintColor.withOpacity(0.56),),),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Список',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
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
