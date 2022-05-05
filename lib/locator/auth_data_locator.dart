import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/locator/core_locator.dart';

void initAuthDataLocator() {
  if (!sLoc.isRegistered<AuthLocalDataSource>(
      instanceName: AuthLocalDataSource.className)) {
    sLoc.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
      instanceName: AuthLocalDataSource.className,
    );
  }

  if (!sLoc.isRegistered<AuthRepository>(
      instanceName: AuthRepository.className)) {
    sLoc.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authLocalDataSource: sLoc<AuthLocalDataSource>(
          instanceName: AuthLocalDataSource.className,
        ),
      ),
      instanceName: AuthRepository.className,
    );
  }
}
