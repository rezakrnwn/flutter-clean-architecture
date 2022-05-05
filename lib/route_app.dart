import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/common/constants/route_name_constant.dart';
import 'package:flutter_clean_architecture/feature/auth/presentation/login/login_page.dart';
import 'package:flutter_clean_architecture/feature/movie/presentation/movie_list/movie_list_page.dart';

class RouteApp {
  static Route<dynamic>? generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNameConstant.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case RouteNameConstant.movieList:
        return MaterialPageRoute(
          builder: (_) => MovieListPage(),
        );
      default:
        return null;
    }
  }
}
