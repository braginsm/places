import 'package:dio/dio.dart';

class HttpClient {
  Dio _dio;
  HttpClient() {
    BaseOptions _options = BaseOptions(
      //baseUrl: "https://test-backend-flutter.surfstudio.ru",
      baseUrl: "https://jsonplaceholder.typicode.com",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      responseType: ResponseType.json,
    );
    _dio = Dio(_options);
    /*_dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print("Request options: ${options.data.toString()}");
        return options;
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print("Response: ${response.data.toString()}");
        return response;
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        print("Error: ${error.error.toString()}");
        return error;
      },
    ));*/
  }

  Future<Response> get(String uri) async {
    return await _dio.get(uri);
  }
}
