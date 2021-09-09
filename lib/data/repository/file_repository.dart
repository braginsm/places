import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/data/res/end_points.dart';

import 'network_exeption.dart';

class FileRepository extends Repository {
  final extList = ['jpeg', 'png', 'gif', 'svg+xml'];

  /// Загрузка файлов
  Future<List<String>> upload(List<String> paths) async {
    assert(paths.isNotEmpty);
    try {
      Map<String, MultipartFile> _map = {};
      for (var path in paths) {
        if (path.isEmpty) continue;
        final fileName = path.split('/').last;
        final mimeList = mime(fileName)!.split('/');
        if (extList.contains(mimeList.last)) {
          _map[fileName] = await MultipartFile.fromFile(
            path,
            filename: fileName,
            contentType: MediaType(mimeList.first, mimeList.last),
          );
        }
      }
      FormData formData = FormData.fromMap(_map);
      Response res = await dio.post(EndPoint.uploadFile, data: formData);
      var result = <String>[];
      res.headers.forEach((name, values) {
        if (name == 'location' && values.isNotEmpty) {
          result.add("${dio.options.baseUrl}${values.first}");
        }
      });
      if (result.isNotEmpty) {
        return result;
      }
      if (res.data['urls'] != null) {
        for (var item in res.data['urls']) {
          result.add("${dio.options.baseUrl}$item");
        }
      }
      return result;
    } on DioError catch (e) {
      throw NetworkExeption(e);
    }
  }
}
