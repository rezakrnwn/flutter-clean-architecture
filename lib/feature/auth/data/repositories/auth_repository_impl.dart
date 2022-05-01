import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/common/execptions/database_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
  }) : _authLocalDataSource = authLocalDataSource;

  @override
  Either<Exception, UserModel> getUser(String username)  {
    try {
      final result = _authLocalDataSource.getUser(username);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseException(message: e.message));
    }
  }
}
