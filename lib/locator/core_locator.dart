import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/common/constants/url_constant.dart';
import 'package:flutter_clean_architecture/common/helpers/dio_helper.dart';
import 'package:flutter_clean_architecture/common/helpers/hive_helper.dart';
import 'package:flutter_clean_architecture/common/helpers/prefs_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sLoc = GetIt.instance;

Future<void> initCoreLocator() async {
  sLoc.registerSingleton<PrefsHelper>(
    PrefsHelper(
      preferences: await SharedPreferences.getInstance(),
    ),
  );

  sLoc.registerSingleton<Dio>(
    DioHelper(baseUrl: UrlConstant.baseUrl).dio,
  );

  sLoc.registerSingleton<HiveHelper>(HiveHelper());
  await sLoc<HiveHelper>().initHive();
}
