import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  static const className = "AuthLocalDataSource";

  UserModel getUser(String username);
}