import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/core.dart';
import '../../auth.dart';

abstract class AuthApiSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  Future<bool> logout();

  Future<bool> changePassword({
    required String oldPassword,
    required String password,
  });

  Future<UserModel> getProfile();

  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? username,
    File? image,
  });
}

class AuthApiSourceImpl implements AuthApiSource {
  AuthApiSourceImpl(this.dio, {required this.authLocalSource});

  final Dio dio;
  final AuthLocalSource authLocalSource;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data!['data'] as Map<String, dynamic>;
        await authLocalSource.saveCache(data['access_token'] as String?);
      }

      final data = response.data!['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>('/auth/register', data: {
        'email': email,
        'username': username,
        'name': name,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data!['data'] as Map<String, dynamic>;
        await authLocalSource.saveCache(data['access_token'] as String?);
      }

      final data = response.data!['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final response = await dio.post<Map<String, dynamic>>('/auth/logout');

      await authLocalSource.clearCache();

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String password,
  }) async {
    try {
      final response = await dio.put<Map<String, dynamic>>('/auth/password', data: {
        'old_password': oldPassword,
        'password': password,
      });

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/auth/profile');

      return UserModel.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? username,
    File? image,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/profile',
        data: FormData.fromMap({
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
          if (username != null) 'username': username,
          if (image != null) 'image': await MultipartFile.fromFile(image.path),
        }),
      );

      return UserModel.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
