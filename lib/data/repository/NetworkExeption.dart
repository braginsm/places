import 'package:dio/dio.dart';

class NetworkExeption implements Exception {
  final DioError error;
  NetworkExeption(this.error) : super();
  @override
  String toString() {
    return "В запросе '${error.requestOptions.baseUrl}${error.requestOptions.path}' возникла ошибка: ${error.message}";
  }
}
