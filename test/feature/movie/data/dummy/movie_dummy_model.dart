import 'package:flutter_clean_architecture/feature/movie/data/models/movie_response.dart';

class MovieDummyModel {
  static List<MovieResultsResponse> movieList() => [
        MovieResultsResponse(
          id: 414906,
          adult: false,
          backdropPath: "/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
          genreIds: [
            80,
            9648,
            53,
          ],
          originalLanguage: "en",
          originalTitle: "The Batman",
          overview:
              "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
          popularity: 5148.49,
          posterPath: "/3VFI3zbuNhXzx7dIbYdmvBLekyB.jpg",
          releaseDate: "2022-03-01",
          title: "The Batman",
          video: false,
          voteAverage: 7.8,
          voteCount: 4223,
        ),
        MovieResultsResponse(
          id: 335787,
          adult: false,
          backdropPath: "/aEGiJJP91HsKVTEPy1HhmN0wRLm.jpg",
          genreIds: [28, 12],
          originalLanguage: "en",
          originalTitle: "Uncharted",
          overview:
              "A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.",
          popularity: 5418.366,
          posterPath: "/tlZpSxYuBRoVJBOpUrPdQe9FmFq.jpg",
          releaseDate: "2022-02-10",
          title: "Uncharted",
          video: false,
          voteAverage: 7.2,
          voteCount: 1628,
        ),
      ];
}
