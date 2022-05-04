import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/use_cases/do_login_use_case.dart';

class DoLoginUseCaseImpl implements DoLoginUseCase {
  final AuthRepository _authRepository;

  DoLoginUseCaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Either<Exception, User> call({
    required DoLoginParams params,
  }) {
    final result = _authRepository.getUser(params.username);

    return result.fold((fail) {
      return Left(fail);
    }, (user) {
      if (params.password == user.password) {
        return Right(user);
      }

      return const Left(DatabaseException(message: "Password is incorrect"));
    });
  }
}

class DoLoginParams extends Equatable {
  final String username;
  final String password;

  DoLoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}
