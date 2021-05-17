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
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print("Response: ${response.data.toString()}");
        return handler.next(response);
      },
      onError: (DioError err, ErrorInterceptorHandler handler) {
        print("Error: ${err.error.toString()}");
        handler.next(err);
      },
    ));
  }
}
