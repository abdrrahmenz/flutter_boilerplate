import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String password,
  });

  Future<Either<Failure, User>> getProfile();

  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? phone,
    String? username,
    File? image,
  });
}
