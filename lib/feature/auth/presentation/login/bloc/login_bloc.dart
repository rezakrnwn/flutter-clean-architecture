import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/common/helpers/prefs_helper.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case_impl.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLoginUseCase _doLoginUseCase;
  final PrefsHelper _prefsHelper;

  LoginBloc({
    required DoLoginUseCase doLoginUseCase,
    required PrefsHelper prefsHelper,
  })  : _doLoginUseCase = doLoginUseCase,
        _prefsHelper = prefsHelper,
        super(LoginInitialState()) {
    on<DoLoginEvent>(_doLogin);
  }

  Future<void> _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginInitialState());
    final result = _doLoginUseCase(
      params: DoLoginParams(
        username: event.username,
        password: event.password,
      ),
    );

    result.fold(
      (failed) => emit(
        LoginFailedState(message: (failed as DatabaseException).message),
      ),
      (user) {
         _prefsHelper.setIsLoggedIn(true);
         _prefsHelper.setUsername(user.username);
        emit(LoginSuccessState());
      },
    );
  }
}
