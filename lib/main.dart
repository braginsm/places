import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/filters.dart';
import 'package:places/ui/screen/onboarding.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:places/ui/screen/splash.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';
import 'ui/screen/sight_card.dart';
import 'ui/screen/sight_list.dart';
import 'ui/screen/visiting.dart';

void main() {
  //лог времени запуска
  print("Start main" + DateTime.now().toString());
  var list = getListString(10000);
  print("after generate" + DateTime.now().toString());
  //print(reversEachItem(list));
  //reversEachItemFuture(list).then((value) => print(value));
  reversEachItemIsolat(list).then((value) => print(value));
  print("after revers" + DateTime.now().toString());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MainState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SightSearchState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => VisitingState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AddSightState(),
        ),
      ],
      child: App(),
    ),
  );
}

class MainState with ChangeNotifier {
  bool _isLight = true;

  ThemeData get theme => _isLight ? lightThema : darkThema;

  bool get isDark => !_isLight;

  void changeTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<MainState>().theme,
      home: SplashScreen(),
      title: "Places",
    );
  }
}

//Методы для 7.4 EventLoop
List<String> getListString(int len) {
  List<String> result = [];
  for (var i = 0; i < len; i++) result.add("string $i");
  return result;
}

String revers(String string) {
  return string.split('').reversed.join();
}

// синхронное выпонение
List<String> reversEachItem(List<String> list) {
  List<String> result = [];
  list.forEach((val) {
    result.add(revers(val));
  });
  return result;
}

// создание Future
Future<List<String>> reversEachItemFuture(List<String> list) {
  return Future<List<String>>.value(reversEachItem(list));
}

// запуск в изоляте
Future<List<String>> reversEachItemIsolat(List<String> list) {
  return compute(reversEachItemFuture, list);
}
