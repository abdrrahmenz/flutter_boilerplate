part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class SubmitLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const SubmitLoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SubmitRegisterEvent extends AuthEvent {
  final String email;
  final String username;
  final String name;
  final String password;

  const SubmitRegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, name, username];
}

class SubmitUpdateProfileEvent extends AuthEvent {
  final String? username;
  final String? name;
  final String? phone;
  final File? image;

  const SubmitUpdateProfileEvent(
      {this.phone, this.name, this.username, this.image});

  @override
  List<Object?> get props => [phone, name, username, image];
}
