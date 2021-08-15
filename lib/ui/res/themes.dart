import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

final lightThema = ThemeData(
  primaryColor: ColorsLightSet.main,
  accentColor: ColorsLightSet.green,
  buttonColor: ColorsLightSet.green,
  canvasColor: ColorsLightSet.white,
  secondaryHeaderColor: ColorsLightSet.secondary,
  hintColor: ColorsLightSet.secondary2,
  unselectedWidgetColor: ColorsLightSet.inactiveBlack,
  backgroundColor: ColorsLightSet.grey,
  indicatorColor: ColorsLightSet.yellow,
  errorColor: ColorsLightSet.red,
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
    titleTextStyle: TextStyleSet().textMedium16.copyWith(color: ColorsLightSet.main),
    centerTitle: true,
  ),
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      primary: ColorsLightSet.green,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: ColorsLightSet.main,
      textStyle: TextStyle(
        color: ColorsLightSet.main,
      ),
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 1,
    activeTrackColor: ColorsLightSet.green,
    inactiveTrackColor: ColorsLightSet.inactiveBlack,
    thumbColor: ColorsLightSet.white,
    overlayColor: ColorsLightSet.grey.withOpacity(0.56),
  ),
  primaryTextTheme: TextTheme(
    headline6: TextStyleSet().textMedium18.copyWith(color: ColorsLightSet.main),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    hintStyle: TextStyleSet().textRegular16.copyWith(color: ColorsLightSet.inactiveBlack),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsLightSet.green),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsLightSet.green),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ColorsLightSet.main,
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(ColorsLightSet.main),
    radius: const Radius.circular(8),
    thickness: MaterialStateProperty.all(8),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
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
    shadowColor: Colors.transparent,
    titleTextStyle: TextStyleSet().textMedium16.copyWith(color: ColorsDarkSet.main),
    centerTitle: true,
  ),
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      primary: ColorsDarkSet.green,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: ColorsDarkSet.white,
      textStyle: TextStyle(
        color: ColorsDarkSet.white,
      ),
    ),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 1,
    activeTrackColor: ColorsLightSet.green,
    inactiveTrackColor: ColorsLightSet.inactiveBlack,
    thumbColor: ColorsLightSet.main,
    overlayColor: ColorsLightSet.grey.withOpacity(0.56),
  ),
  primaryTextTheme: TextTheme(
    headline6: TextStyleSet().textMedium18.copyWith(color: ColorsDarkSet.main),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
