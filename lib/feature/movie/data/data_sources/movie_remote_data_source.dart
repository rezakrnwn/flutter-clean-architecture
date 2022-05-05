import 'package:flutter_clean_architecture/feature/movie/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieResultsResponse>> getDiscover(int page);
}