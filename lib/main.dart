import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/geo_interactor.dart';
import 'package:provider/provider.dart';

import 'data/blocks/place_list/place_list_bloc.dart';
import 'data/interactor/place_favorit_interactor.dart';
import 'data/interactor/place_interactor.dart';
import 'data/interactor/place_visit_interactor.dart';
import 'data/interactor/search_history_interactor.dart';
import 'data/interactor/search_interactor.dart';
import 'data/interactor/user_property_interactor.dart';
import 'ui/res/themes.dart';
import 'ui/screen/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MainState(),
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
          create: (_) => SearchHistoryInteractor(),
        ),
        Provider(
          create: (_) => PlaceFavoritInteractor(),
        ),
        Provider(
          create: (_) => PlaceVisitInteractor(),
        ),
        Provider(
          create: (_) => GeoInteractor(),
        ),
        Provider(
          create: (_) => PlaceListBloc(PlaceInteractor()),
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
