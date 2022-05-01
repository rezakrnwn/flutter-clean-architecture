import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthLocalDataSource])
void main() {
  late AuthRepository repository;
  late MockAuthLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(authLocalDataSource: localDataSource);
  });

  test('should return user entity when successful get user data', () {
    // arrange
    String username = "admin";
    UserModel dummyUserModel = UserModel(username: username, password: "123");
    User dummyUserEntity = User(
      username: dummyUserModel.username,
      password: dummyUserModel.password,
    );
    when(localDataSource.getUser(username)).thenAnswer((_) => dummyUserModel);
    // act
    final result = repository.getUser(username);
    // assert
    expect(result.toOption().toNullable(), dummyUserEntity);
  });

  test('should throw exception when user data is not found', () {
    // arrange
    String username = "reza";
    when(localDataSource.getUser(username)).thenAnswer(
        (_) => throw const DatabaseException(message: "User not found"));
    // act
    final result = repository.getUser(username);
    // assert
    verify(localDataSource.getUser(username));
    expect(result.isLeft(), true);
    expect(result.swap().toOption().toNullable(),
        const DatabaseException(message: "User not found"));
  });
}
