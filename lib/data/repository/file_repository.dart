import 'dart:convert';

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
        final fileName = path.split('/').last;
        _map[fileName] = await MultipartFile.fromFile(path, filename: fileName);
      }
      FormData formData = FormData.fromMap(_map);
      Response res = await dio.put(EndPoint.uploadFile, data: formData);
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
