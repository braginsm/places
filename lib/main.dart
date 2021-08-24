import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/interactor/place_interactor.dart';
import 'data/interactor/search_interactor.dart';
import 'data/interactor/user_property_interactor.dart';
import 'database/database.dart';
import 'ui/res/themes.dart';
import 'ui/screen/splash.dart';
import 'ui/screen/visiting.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MainState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => VisitingState(),
        ),
        Provider(
          create: (_) => PlaceInteractor(),
        ),
        Provider(
          create: (_) => SerachInteractor(),
        ),
        Provider(
          create: (_) => UserPropertyInteractor(),
        ),
        Provider(
          create: (_) => AppDb(),
        ),
      ],
      child: const App(),
    ),
  );
}

class MainState with ChangeNotifier {
  ThemeData theme = lightThema;
  bool get isDark => theme == darkThema;

  void changeTheme(bool value) {
    theme = value ? darkThema : lightThema;
    notifyListeners();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<MainState>().theme,
      home: const SplashScreen(),
      title: "Places",
    );
  }
}
