import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case_impl.dart';

abstract class DoLoginUseCase {
  Either<Exception, User> call({
    required DoLoginParams params,
  });
}
