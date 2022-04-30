import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Either<DatabaseException, UserModel> getUser(String username);
}