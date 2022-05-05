import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/constants/route_name_constant.dart';
import 'package:flutter_clean_architecture/common/helpers/bloc_observer_helper.dart';
import 'package:flutter_clean_architecture/common/helpers/prefs_helper.dart';
import 'package:flutter_clean_architecture/locator/core_locator.dart';
import 'package:flutter_clean_architecture/route_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCoreLocator();
  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(const MainApp()),
        blocObserver: BlocObserverHelper(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: sLoc<PrefsHelper>().isLoggedIn()
          ? RouteNameConstant.movieList
          : RouteNameConstant.login,
      onGenerateRoute: RouteApp.generate,
      debugShowCheckedModeBanner: false,
    );
  }
}
