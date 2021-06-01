import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/sight_search.dart';
import 'package:places/ui/screen/smthError.dart';
import 'package:places/ui/screen/splash.dart';
import 'package:provider/provider.dart';
import 'data/interactor/SettingsInteractor.dart';
import 'ui/screen/visiting.dart';

Future<void> main() async {
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
  ThemeData get theme => themeIsBlack ? darkThema : lightThema;

  bool get isDark => themeIsBlack;

  void changeTheme() {
    SettingsInteractor().toggleTheme();
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
