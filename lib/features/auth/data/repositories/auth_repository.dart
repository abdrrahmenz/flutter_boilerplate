import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.authApiSource);

  final AuthApiSource authApiSource;

  @override
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String password,
  }) async {
    try {
      final result = await authApiSource.changePassword(
        oldPassword: oldPassword,
        password: password,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authApiSource.login(
        email: email,
        password: password,
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await authApiSource.logout();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final result = await authApiSource.register(
        email: email,
        name: name,
        username: username,
        password: password,
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final result = await authApiSource.getProfile();

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? phone,
    String? username,
    File? image,
  }) async {
    try {
      final result = await authApiSource.updateProfile(
        name: name,
        username: username,
        image: image,
        phone: phone,
      );

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
