import 'package:dio/dio.dart';

class Repository {
  Dio dio;
  Repository() {
    BaseOptions _options = BaseOptions(
      baseUrl: "https://test-backend-flutter.surfstudio.ru",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      responseType: ResponseType.json,
    );
    dio = Dio(_options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print('send request：path:${options.path}，baseURL:${options.baseUrl}');
        return handler.next(options);
      },
      onResponse: _onResponse,
      onError: (DioError err, ErrorInterceptorHandler handler) {
        print("Error: ${err.error.toString()}");
        handler.next(err);
      },
    ));
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    /// Проверка статуса запроса
    switch (response.statusCode) {
      case 200:
        return handler.next(response);
        break;
      case 400:
      case 409:
        throw Exception(response.data['error']);
        break;
      case 404:
        throw Exception("No object found.");
      default:
        throw Exception("error: status code ${response.statusCode}");
    }
  }
}
