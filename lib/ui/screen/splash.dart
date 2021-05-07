import 'package:flutter/material.dart';
import 'package:places/ui/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future isInitialized;

  @override
  void initState() {
    //лог времени запуска
    print(DateTime.now());
    _navigateToNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.amber,
      ),
    );
  }

  Future<void> _navigateToNext() async {
    // имитация запроса данных
    Future dataUpload = Future.delayed(Duration(seconds: 1), () => true);

    try {
      isInitialized = await Future.delayed(Duration(seconds: 2), () async {
        if (await dataUpload) {
          print("${DateTime.now()}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OnboardingScreen();
              },
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
