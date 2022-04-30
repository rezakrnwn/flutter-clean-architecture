import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthLocalDataSource dataSource;
  late UserModel dummyUserModel;

  setUp(() {
    dataSource = AuthLocalDataSourceImpl();
    dummyUserModel = const UserModel(username: "admin", password: "123");
  });

  test('should return user model when username equals admin', () {
    // arrange
    String username = "admin";
    // act
    final result = dataSource.getUser(username);
    // assert
    expect(result.toOption().toNullable(), dummyUserModel);
  });

  test('should return database exception when username not equals admin', () {
    // arrange
    String username = "reza";
    // act
    final result = dataSource.getUser(username);
    // assert
    expect(result.swap().toOption().toNullable(),
        const DatabaseException(message: "User not found"));
  });
}
