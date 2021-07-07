import 'package:mwwm/mwwm.dart';

class StandartErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    print('Handled error: $e');
  }
}
