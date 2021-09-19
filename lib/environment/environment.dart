import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';

class Environment {
  final BuildConfig buildConfig;
  final BuildType buildType;

  static Environment? _environment;

  Environment._(this.buildConfig, this.buildType);

  static init(BuildConfig buildConfig, BuildType buildType) {
    _environment = Environment._(buildConfig, buildType);
  }

  static Environment instance() => _environment!;
}
