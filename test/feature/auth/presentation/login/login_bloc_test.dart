import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/common/helpers/prefs_helper.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([
  DoLoginUseCase,
  PrefsHelper,
])
void main() {
  late LoginBloc bloc;
  late MockDoLoginUseCase doLoginUseCase;
  late MockPrefsHelper prefsHelper;
  late DoLoginParams params;

  setUp(() {
    doLoginUseCase = MockDoLoginUseCase();
    prefsHelper = MockPrefsHelper();
    bloc = LoginBloc(
      doLoginUseCase: doLoginUseCase,
      prefsHelper: prefsHelper,
    );
  });

  blocTest<LoginBloc, LoginState>(
    "should emit [LoginInitialState, LoginSuccessState] when login is successfully",
    build: () => bloc,
    setUp: () async {
      final dummyUserEntity = User(username: "admin", password: "123");
      params = DoLoginParams(username: "admin", password: "123");
      when(doLoginUseCase(params: params))
          .thenAnswer((_) => Right(dummyUserEntity));
      when(prefsHelper.setIsLoggedIn(true)).thenAnswer((_) async => true);
      when(prefsHelper.setUsername(params.username))
          .thenAnswer((_) async => true);
    },
    act: (bloc) => bloc.add(DoLoginEvent(
      username: params.username,
      password: params.password,
    )),
    verify: (bloc) {
      verify(doLoginUseCase(
        params: params,
      ));
      verify(prefsHelper.setIsLoggedIn(true));
      verify(prefsHelper.setUsername(params.username));
    },
    expect: () => [
      LoginInitialState(),
      LoginSuccessState(),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    "should emit [LoginInitialState, LoginFailedState] when user not found",
    build: () => bloc,
    setUp: () {
      params = DoLoginParams(username: "reza", password: "222");
      when(doLoginUseCase(params: params)).thenAnswer(
              (_) => const Left(DatabaseException(message: "User not found")));
    },
    act: (bloc) => bloc.add(DoLoginEvent(
      username: params.username,
      password: params.password,
    )),
    verify: (bloc) => verify(doLoginUseCase(
      params: params,
    )),
    expect: () => [
      LoginInitialState(),
      LoginFailedState(message: "User not found"),
    ],
  );
}
