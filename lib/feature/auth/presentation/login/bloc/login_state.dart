part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final String? message;

  LoginFailedState({
    this.message = "Login failed",
  });

  @override
  List<Object?> get props => [message];
}
