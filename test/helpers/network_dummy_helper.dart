import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/common/constants/url_constant.dart';

import 'json_reader.dart';

class NetworkDummyHelper {
  static Response response({
    required String path,
    required String responseJsonPath,
    required int statusCode,
    String? baseUrl = UrlConstant.baseUrl,
  }) =>
      Response(
        requestOptions: RequestOptions(
          baseUrl: baseUrl,
          path: path,
        ),
        statusCode: statusCode,
        data: json.decode(
          readJson(
            responseJsonPath,
          ),
        ),
      );
}
