import 'package:flutter_clean_architecture/common/constants/route_name_constant.dart';
import 'package:flutter_clean_architecture/common/helpers/prefs_helper.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/locator/auth_data_locator.dart';
import 'package:flutter_clean_architecture/locator/core_locator.dart';

void initLoginLocatorScope() {
  if (sLoc.currentScopeName != RouteNameConstant.login) {
    sLoc.pushNewScope(scopeName: RouteNameConstant.login);

    initAuthDataLocator();

    sLoc.registerLazySingleton<DoLoginUseCase>(
      () => DoLoginUseCaseImpl(
        authRepository:
            sLoc<AuthRepository>(instanceName: AuthRepository.className),
      ),
    );

    sLoc.registerLazySingleton<LoginBloc>(
      () => LoginBloc(
        doLoginUseCase: sLoc<DoLoginUseCase>(),
        prefsHelper: sLoc<PrefsHelper>(),
      ),
    );
  }
}
