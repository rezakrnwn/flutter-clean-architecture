import 'package:dio/dio.dart';

class DioHelper {
  final String _baseUrl;

  Dio get dio => _getDio();

  DioHelper({
    required String baseUrl,
  }) : _baseUrl = baseUrl;

  Dio _getDio() => Dio(BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
      ));
}
