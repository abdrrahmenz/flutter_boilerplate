import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

class UpdateProfileUseCase
    implements UseCaseFuture<Failure, User, UpdateProfileParams> {
  UpdateProfileUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, User>> call(UpdateProfileParams params) async {
    return authRepository.updateProfile(
      image: params.image,
      name: params.name,
      phone: params.phone,
      username: params.username,
    );
  }
}

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams({
    this.name,
    this.phone,
    this.image,
    this.username,
  });

  final String? name;
  final String? phone;
  final String? username;
  final File? image;

  @override
  List<Object?> get props => [name, phone, username, image];
}
