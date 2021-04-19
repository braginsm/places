import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/filters.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:provider/provider.dart';

import 'mocks.dart';
import 'ui/screen/sight_card.dart';
import 'ui/screen/sight_list.dart';
import 'ui/screen/visiting.dart';

void main() {
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
          create: (BuildContext context) => VisitingState()
        )
      ],
      child: App(),
    ),
  );
  //runApp(App());
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
      home: SightListScreen(),
      title: "Places",
    );
  }
}
