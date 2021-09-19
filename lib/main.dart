import 'package:flutter/material.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  _defineEnvironment(_setUpConfig());
  runApp(
    MultiProvider(
      providers: providers,
      child: const App(),
    ),
  );
}

void _defineEnvironment(BuildConfig buildConfig) {
  Environment.init(buildConfig, BuildType.dev);
}

BuildConfig _setUpConfig() {
  return BuildConfig("");
}
