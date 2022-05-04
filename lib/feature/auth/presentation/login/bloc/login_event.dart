part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoLoginEvent extends LoginEvent {
  final String username;
  final String password;

  DoLoginEvent({
    required this.username,
    required this.password,
  });
}
