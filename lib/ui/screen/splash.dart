import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:places/data/interactor/user_property_interactor.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future? isInitialized;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
          builder: (BuildContext context, Widget? child) {
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
    /// получение начальных данных приложения
    Future<bool> appDataInit = Future(() async {
      context.read<MainState>().changeTheme(
        await context.read<UserPropertyInteractor>().getDarkTheme()
      );
      return true;
    });

    try {
      isInitialized =
          await Future.delayed(const Duration(seconds: 2), () async {
        if (await appDataInit) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            ),
          );
        } else {
          throw Exception("Ошибка загрузки данных");
        }
        return;
      });
    } catch (e) {
      rethrow;
    }
  }
}
