import 'package:flutter/material.dart';
import 'package:places/ui/res/images.dart';
import 'package:animated_rotation/animated_rotation.dart';

class PreloaderWidget extends StatefulWidget {
  const PreloaderWidget({Key key}) : super(key: key);

  @override
  _PreloaderWidgetState createState() => _PreloaderWidgetState();
}

class _PreloaderWidgetState extends State<PreloaderWidget> {
  int _angle = 0;
  final int _duration = 2;

  @override
  void initState() {
    _animation();
    super.initState();
  }

  Future<void> _animation() async {
    await Future.delayed(Duration.zero);
    while (0 < 1) {
      setState(() {
        _angle = _angle - 360;
      });
      await Future.delayed(Duration(seconds: _duration));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedRotation(
        duration: Duration(seconds: _duration),
        angle: _angle,
        child: Image.asset(
          ImagesPaths.ellipse,
        ),
      ),
    );
  }
}
