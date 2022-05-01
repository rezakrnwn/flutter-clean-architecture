import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';

abstract class DoLoginUseCase {
  Either<Exception, User> call({
    required String username,
    required String password,
  });
}
