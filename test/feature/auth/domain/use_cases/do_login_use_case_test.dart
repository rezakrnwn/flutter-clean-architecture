import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'do_login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository authRepository;
  late DoLoginUseCase doLoginUseCase;

  setUp(() {
    authRepository = MockAuthRepository();
    doLoginUseCase = DoLoginUseCaseImpl(authRepository: authRepository);
  });

  test('should return user entity when username and password are equals', () {
    // arrange
    final params = DoLoginParams(username: "admin", password: "123");
    User dummyUserEntity = User(
      username: params.username,
      password: params.password,
    );
    when(authRepository.getUser(params.username))
        .thenAnswer((_) => Right(dummyUserEntity));
    // act
    final result = doLoginUseCase(params: params);
    // assert
    verify(authRepository.getUser(params.username));
    expect(result.isRight(), true);
    expect(result.toOption().toNullable(), dummyUserEntity);
  });

  test('should throw exception when password is incorrect', () {
    // arrange
    String correctPassword = "123";
    final params = DoLoginParams(username: "admin", password: "222");
    User dummyUserEntity = User(
      username: params.username,
      password: correctPassword,
    );
    when(authRepository.getUser(params.username))
        .thenAnswer((_) => Right(dummyUserEntity));
    // act
    final result = doLoginUseCase(params: params);
    // assert
    verify(authRepository.getUser(params.username));
    expect(result.isLeft(), true);
    expect(result.swap().toOption().toNullable(),
        const DatabaseException(message: "Password is incorrect"));
  });

  test('should throw exception when user not found', () {
    // arrange
    final params = DoLoginParams(username: "reza", password: "222");
    when(authRepository.getUser(params.username)).thenAnswer(
        (_) => const Left(DatabaseException(message: "User not found")));
    // act
    final result = doLoginUseCase(params: params);
    // assert
    verify(authRepository.getUser(params.username));
    expect(result.isLeft(), true);
    expect(result.swap().toOption().toNullable(),
        const DatabaseException(message: "User not found"));
  });
}
