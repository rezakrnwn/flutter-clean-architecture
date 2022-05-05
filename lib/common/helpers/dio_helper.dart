import 'package:dio/dio.dart';

class DioHelper {
  static const String apiKey = "a89c3d590e198d4223e7c48de054c21d";
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
