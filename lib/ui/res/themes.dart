import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

final lightThema = ThemeData(
  primaryColor: ColorsLightSet.main,
  accentColor: ColorsLightSet.main,
  canvasColor: ColorsLightSet.white,
  secondaryHeaderColor: ColorsLightSet.secondary,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: ColorsLightSet.main,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: ColorsLightSet.secondary,
    type: BottomNavigationBarType.fixed
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: ColorsLightSet.secondary2.withOpacity(0.56),
    labelColor: ColorsLightSet.white,
    unselectedLabelStyle: TextStyleSet().textBold,
    labelStyle: TextStyleSet().textBold,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(40),
      color: ColorsLightSet.secondary,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsLightSet.white,
    shadowColor: Colors.transparent,
  ),
  fontFamily: 'Roboto',
);
