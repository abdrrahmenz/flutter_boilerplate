import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../features/auth/auth.dart';

/// Error handling when error in interceptor about authentication
class AuthHttpInterceptor extends InterceptorsWrapper {
  /// Repository to get data current token
  final AuthLocalSource authLocalSource;
  final VoidCallback? onUnAuth;

  ///
  AuthHttpInterceptor({
    required this.authLocalSource,
    this.onUnAuth,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authLocalSource.getData();

    log('$token', name: 'TOKEN');

    final optionHeaders = <String, Object>{};

    if (token != null) {
      optionHeaders.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    options.headers.addAll(optionHeaders);
    handler.next(options);
  }
}
