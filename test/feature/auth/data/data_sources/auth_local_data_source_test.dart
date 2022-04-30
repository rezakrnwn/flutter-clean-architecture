import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthLocalDataSource dataSource;

  setUp(() {
    dataSource = AuthLocalDataSourceImpl();
  });

  test('should return user model when username equals admin', () {
    // arrange
    String username = "admin";
    UserModel dummyUserModel = const UserModel(username: "admin", password: "123");
    // act
    final result = dataSource.getUser(username);
    // assert
    expect(result, dummyUserModel);
  });

  test('should throw database exception when username not equals admin', () {
    // arrange
    String username = "reza";
    // act
    final Function(String username) call = dataSource.getUser;
    // assert
    expect(() => call(username), throwsException);
  });
}
