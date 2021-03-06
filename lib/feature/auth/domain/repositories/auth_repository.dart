import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  static const className = "AuthRepository";

  Either<Exception, User> getUser(String username);
}