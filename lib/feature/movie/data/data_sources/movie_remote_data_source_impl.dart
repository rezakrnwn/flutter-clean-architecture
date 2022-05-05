import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/common/constants/url_constant.dart';
import 'package:flutter_clean_architecture/common/execptions/network_exception.dart';
import 'package:flutter_clean_architecture/common/helpers/dio_helper.dart';
import 'package:flutter_clean_architecture/feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:flutter_clean_architecture/feature/movie/data/models/movie_response.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<MovieResultsResponse>> getDiscover(int page) async {
    try {
      final Response response =
          await _dio.get(UrlConstant.getDiscoverMovies, queryParameters: {
        "api_key": DioHelper.apiKey,
        "page": page,
      });
      return MovieResponse.fromJson(response.data).results ?? [];
    } on DioError catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? "error",
      );
    }
  }
}
