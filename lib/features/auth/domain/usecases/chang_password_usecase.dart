import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class ChangePasswordUseCase
    implements UseCaseFuture<Failure, bool, ChangePasswordParams> {
  ChangePasswordUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, bool>> call(ChangePasswordParams params) async {
    return authRepository.changePassword(
      oldPassword: params.oldPassword,
      password: params.password,
    );
  }
}

class ChangePasswordParams extends Equatable {
  const ChangePasswordParams({
    required this.oldPassword,
    required this.password,
  });

  final String oldPassword;
  final String password;

  @override
  List<Object?> get props => [oldPassword, password];
}
