import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user.dart';

class AuthMapper {
  static User userModelToUserDomain(UserModel userModel) => User(
        username: userModel.username,
        password: userModel.password,
      );

  static UserModel userDomainToUserModel(User user) => UserModel(
        username: user.username,
        password: user.password,
      );
}
