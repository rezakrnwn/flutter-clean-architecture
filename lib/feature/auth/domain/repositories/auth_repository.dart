import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Either<Exception, UserModel> getUser(String username);
}