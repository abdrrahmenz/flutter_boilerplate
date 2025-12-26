part of 'form_auth_bloc.dart';

abstract class FormAuthEvent extends Equatable {
  const FormAuthEvent();

  @override
  List<Object> get props => [];
}

class InitialFormAuthEvent extends FormAuthEvent {}

class ChangeEmailFormAuthEvent extends FormAuthEvent {
  final String email;

  const ChangeEmailFormAuthEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ChangePasswordFormAuthEvent extends FormAuthEvent {
  final String password;

  const ChangePasswordFormAuthEvent(this.password);

  @override
  List<Object> get props => [password];
}

class ChangeNameFormAuthEvent extends FormAuthEvent {
  final String name;

  const ChangeNameFormAuthEvent(this.name);

  @override
  List<Object> get props => [name];
}

class ChangeUsernameFormAuthEvent extends FormAuthEvent {
  final String username;

  const ChangeUsernameFormAuthEvent(this.username);

  @override
  List<Object> get props => [username];
}

class ChangeEmailRegisterFormAuthEvent extends FormAuthEvent {
  final String email;

  const ChangeEmailRegisterFormAuthEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ChangePasswordRegisterFormAuthEvent extends FormAuthEvent {
  final String password;

  const ChangePasswordRegisterFormAuthEvent(this.password);

  @override
  List<Object> get props => [password];
}
