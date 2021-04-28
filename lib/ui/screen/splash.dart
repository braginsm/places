import 'package:flutter/material.dart';

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

  void _navigateToNext() {
    // имитация запроса данных
    Future dataUpload = Future.delayed(Duration(seconds: 5), () => true);
    
    isInitialized = Future.delayed(
            Duration(seconds: 2), () => "Переход на следующий экран")
        .then((value) => dataUpload.then(
            (val) => val ? print("${DateTime.now()} $value") : print("Error data not found")));
  }
}
