import 'package:flutter/foundation.dart';
import 'package:mwwm/mwwm.dart';

class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint(e.toString());
  }
}