part of 'form_auth_bloc.dart';

class FormAuthState extends Equatable {
  const FormAuthState({
    this.email = const EmailFormZ.dirty(),
    this.password = const PasswordFormZ.dirty(),
    this.name = const NameFormZ.dirty(),
    this.username = const NameFormZ.dirty(),
    this.emailRegister = const EmailFormZ.dirty(),
    this.passwordRegister = const PasswordFormZ.dirty(),
  });

  factory FormAuthState.initial() {
    return const FormAuthState();
  }

  final EmailFormZ email;
  final PasswordFormZ password;
  final NameFormZ name;
  final NameFormZ username;
  final EmailFormZ emailRegister;
  final PasswordFormZ passwordRegister;

  bool get isValid =>
      email.isValid &&
      password.isValid &&
      email.value.isNotEmpty &&
      password.value.isNotEmpty;

  bool get isValidRegister =>
      emailRegister.isValid &&
      passwordRegister.isValid &&
      emailRegister.value.isNotEmpty &&
      passwordRegister.value.isNotEmpty &&
      name.isValid &&
      username.isValid &&
      name.value.isNotEmpty &&
      username.value.isNotEmpty;

  FormAuthState copyWith({
    EmailFormZ? email,
    PasswordFormZ? password,
    NameFormZ? name,
    NameFormZ? username,
    EmailFormZ? emailRegister,
    PasswordFormZ? passwordRegister,
  }) {
    return FormAuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailRegister: emailRegister ?? this.emailRegister,
      name: name ?? this.name,
      passwordRegister: passwordRegister ?? this.passwordRegister,
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        name,
        username,
        emailRegister,
        passwordRegister,
      ];
}
