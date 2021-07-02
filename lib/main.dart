import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/interactor/PlaceInteractor.dart';
import 'package:places/data/interactor/SearchInteractor.dart';
import 'package:places/data/redux/middleware/search_middleware.dart';
import 'package:places/data/redux/reducer/reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/add_sight.dart';
import 'package:places/ui/screen/select_category.dart';
import 'package:places/ui/screen/splash.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'data/interactor/SettingsInteractor.dart';
import 'ui/screen/visiting.dart';

void main() {
  final store = Store<AppState>(
    reducer, 
    initialState: AppState(), 
    middleware: [
      SearchMiddleware(SerachInteractor()),
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MainState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => VisitingState(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AddSightState(),
        ),
        Provider(
          create: (_) => PlaceInteractor(),
        ),
        Provider(
          create: (_) => SerachInteractor(),
        ),
      ],
      child: App(
        store: store,
      ),
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
  final Store<AppState> store;
  const App({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: context.watch<MainState>().theme,
        //home: SplashScreen(),
        home: AddSightScreen(),
        title: "Places",
      ),
    );
  }
}
