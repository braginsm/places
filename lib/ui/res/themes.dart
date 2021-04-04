import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

final lightThema = ThemeData(
  primaryColor: ColorsLightSet.main,
  accentColor: ColorsLightSet.green,
  canvasColor: ColorsLightSet.white,
  secondaryHeaderColor: ColorsLightSet.secondary,
  hintColor: ColorsLightSet.secondary2,
  unselectedWidgetColor: ColorsLightSet.inactiveBlack,
  backgroundColor: ColorsLightSet.grey,
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

final darkThema = ThemeData(
  scaffoldBackgroundColor: ColorsDarkSet.main,
  primaryColor: ColorsDarkSet.white,
  accentColor: ColorsDarkSet.green,
  canvasColor: ColorsDarkSet.white,
  //secondaryHeaderColor: ColorsDarkSet.secondary2,
  hintColor: ColorsDarkSet.secondary2,
  unselectedWidgetColor: ColorsDarkSet.inactiveBlack,
  backgroundColor: ColorsDarkSet.dark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: ColorsDarkSet.white,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: ColorsDarkSet.secondary,
    type: BottomNavigationBarType.fixed,
    backgroundColor: ColorsDarkSet.main, 
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: ColorsDarkSet.secondary2.withOpacity(0.56),
    labelColor: ColorsDarkSet.main,
    unselectedLabelStyle: TextStyleSet().textBold,
    labelStyle: TextStyleSet().textBold,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(40),
      color: ColorsDarkSet.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsDarkSet.main,
    //color: ColorsDarkSet.white,
    shadowColor: Colors.transparent,
  ),
  fontFamily: 'Roboto',
);
