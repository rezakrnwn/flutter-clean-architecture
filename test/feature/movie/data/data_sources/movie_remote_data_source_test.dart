import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/common/constants/url_constant.dart';
import 'package:flutter_clean_architecture/common/execptions/network_exception.dart';
import 'package:flutter_clean_architecture/common/helpers/dio_helper.dart';
import 'package:flutter_clean_architecture/feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:flutter_clean_architecture/feature/movie/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:flutter_clean_architecture/feature/movie/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/network_dummy_helper.dart';
import '../dummy/movie_dummy_model.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Dio>(as: #MockDio),
  ],
)
void main() {
  late MockDio dio;
  late MovieRemoteDataSource movieRemoteDataSource;
  String discoverMovieJsonPath =
      'feature/movie/data/dummy/responses/discover_movie.json';
  String discoverMovieEmptyJsonPath =
      'feature/movie/data/dummy/responses/discover_movie_empty.json';

  setUp(() {
    dio = MockDio();
    movieRemoteDataSource = MovieRemoteDataSourceImpl(dio: dio);
  });

  test('should return discover movie list when the response code is 200',
      () async {
    // arrange
    final queryParameters = {
      'api_key': DioHelper.apiKey,
      'page': 1,
    };
    when(dio.get(
      UrlConstant.getDiscoverMovies,
      queryParameters: queryParameters,
    )).thenAnswer(
      (_) async => NetworkDummyHelper.response(
          path: UrlConstant.baseUrl,
          responseJsonPath: discoverMovieJsonPath,
          statusCode: 200),
    );
    // act
    final result = await movieRemoteDataSource.getDiscover(1);
    // assert
    verify(dio.get(
      UrlConstant.getDiscoverMovies,
      queryParameters: queryParameters,
    ));
    expect(result, MovieDummyModel.movieList());
  });

  test('should return empty list when the response code is 200', () async {
    // arrange
    final queryParameters = {
      'api_key': DioHelper.apiKey,
      'page': 1,
    };
    when(dio.get(UrlConstant.getDiscoverMovies,
            queryParameters: queryParameters))
        .thenAnswer(
      (_) async => NetworkDummyHelper.response(
        path: UrlConstant.baseUrl,
        responseJsonPath: discoverMovieEmptyJsonPath,
        statusCode: 200,
      ),
    );
    // act
    final result = await movieRemoteDataSource.getDiscover(1);
    // assert
    expect(result, <MovieResultsResponse>[]);
  });

  test('should throw exception when response code is not 200', () async {
    // arrange
    final queryParameters = {
      'api_key': DioHelper.apiKey,
      'page': 1,
    };
    when(dio.get(UrlConstant.getDiscoverMovies,
            queryParameters: queryParameters))
        .thenAnswer((_) async =>
            Future.error(NetworkException(statusCode: 401, message: "error")));
    try {
      // act
      await movieRemoteDataSource.getDiscover(1);
    } catch (e) {
      // assert
      expect(e, NetworkException(statusCode: 401, message: "error"));
    }
  });
}
