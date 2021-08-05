import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/onboarding.dart';

import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future isInitialized;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ));
    _animationController.repeat();
    _navigateToNext();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).indicatorColor,
            Theme.of(context).accentColor
          ],
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: -_animation.value,
              child: SvgPicture.asset(ImagesPaths.splash),
            );
          },
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    // имитация запроса данных
    Future dataUpload = Future.delayed(Duration(seconds: 5), () => true);

    try {
      isInitialized = await Future.delayed(Duration(seconds: 2), () async {
        if (await dataUpload) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OnboardingScreen(),
            ),
          );
        } else
          throw Exception("Ошибка загрузки данных");
        return;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
