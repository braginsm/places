import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/splash.dart';
import 'package:provider/provider.dart';
import 'data/interactor/settings_interactor.dart';
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
      ],
      child: const App(),
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
