import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class RegisterUseCase implements UseCaseFuture<Failure, User, RegisterParams> {
  RegisterUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, User>> call(RegisterParams params) async {
    return authRepository.register(
      name: params.name,
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  final String name;
  final String username;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, username, email, password];
}
