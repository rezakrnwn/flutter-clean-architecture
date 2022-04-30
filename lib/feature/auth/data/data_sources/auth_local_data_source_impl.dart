import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Either<DatabaseException, UserModel> getUser(String username) {
    try {
      if (username == "admin") {
        return const Right(UserModel(username: "admin", password: "123"));
      }

      throw const DatabaseException(message: "User not found");
    } on DatabaseException catch (e) {
      return Left(e);
    }
  }
}