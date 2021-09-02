import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/data/res/end_points.dart';

import 'network_exeption.dart';

class FileRepository extends Repository {
  /// Загрузка файлов
  Future<List<String>> upload(List<String> paths) async {
    assert(paths.isNotEmpty);
    try {
      Map<String, MultipartFile> _map = {};
      for (var path in paths) {
        if (path.isEmpty) continue;
        final fileName = path.split('/').last;
        final ext = fileName.split('.').last;
        _map[fileName] = await MultipartFile.fromFile(path,
            filename: fileName,
            contentType: MediaType.parse("image/$ext"));
      }
      FormData formData = FormData.fromMap(_map);
      Response res = await dio.post(EndPoint.uploadFile, data: formData);
      var result = <String>[];
      res.headers.forEach((name, values) {
        if (name == 'location' && values.isNotEmpty) {
          result.addAll(values);
        }
      });
      return result.isEmpty ? jsonDecode(res.data) : result;
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }
}
