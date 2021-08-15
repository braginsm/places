import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/images.dart';

class PreloaderWidget extends StatefulWidget {
  const PreloaderWidget({Key? key}) : super(key: key);

  @override
  _PreloaderWidgetState createState() => _PreloaderWidgetState();
}

class _PreloaderWidgetState extends State<PreloaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: 2 * pi,
      lowerBound: 0,
    );
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Center(
          child: Transform.rotate(
            angle: -_animationController.value,
            child: Image.asset(
              ImagesPaths.ellipse,
            ),
          ),
        );
      },
    );
  }
}
