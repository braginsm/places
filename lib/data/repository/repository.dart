import 'package:dio/dio.dart';

class Repository {
  late Dio dio;
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
        // ignore: avoid_print
        print(
            'send request to URL:${options.baseUrl}${options.path} with params: ${options.queryParameters} ${options.data}');
        return handler.next(options);
      },
      onResponse: _onResponse,
      onError: (DioError err, ErrorInterceptorHandler handler) {
        // ignore: avoid_print
        print("Error: ${err.error.toString()}");
        handler.next(err);
      },
    ));
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    /// Проверка статуса запроса
    switch (response.statusCode) {
      case 200:
      case 201:
        // ignore: avoid_print
        print("responce data: ${response.data}");
        return handler.next(response);
      case 400:
      case 409:
        throw Exception(response.data['error']);
      case 404:
        throw Exception("No object found.");
      default:
        throw Exception("error: status code ${response.statusCode}");
    }
  }
}
