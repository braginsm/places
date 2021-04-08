import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/filters_screen.dart';

import 'mocks.dart';
import 'ui/screen/sight_card.dart';
import 'ui/screen/sight_list.dart';
import 'ui/screen/visiting.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: darkThema,
      theme: lightThema,
      home: FiltersScreen(),
      title: "Places",
    );
  }
}
