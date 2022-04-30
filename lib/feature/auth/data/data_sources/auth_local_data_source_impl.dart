import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  UserModel getUser(String username) {
    if (username == "admin") {
      return const UserModel(username: "admin", password: "123");
    }

    throw const DatabaseException(message: "User not found");
  }
}