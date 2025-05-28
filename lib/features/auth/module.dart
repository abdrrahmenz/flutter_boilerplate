import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import 'auth.dart';

class AuthModule implements BaseModule {
  @override
  Future inject(GetIt getIt) async {
    // Data
  getIt
    ..registerLazySingleton<AuthApiSource>(
      () => AuthApiSourceImpl(getIt(), authLocalSource: getIt()),
    )
    ..registerLazySingleton<AuthLocalSource>(
      () => AuthLocalSourceImpl(getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()),
    );

    // Domain
    getIt
    ..registerLazySingleton(() => LoginUseCase(getIt()))
    ..registerLazySingleton(() => RegisterUseCase(getIt()))
    ..registerLazySingleton(() => ChangePasswordUseCase(getIt()))
    ..registerLazySingleton(() => UpdateProfileUseCase(getIt()))
    ..registerLazySingleton(() => GetProfileUseCase(getIt()))
    ..registerLazySingleton(() => LogoutUseCase(getIt()));

    // Presentation
     getIt
    ..registerLazySingleton(() => AuthBloc(
          changePasswordUseCase: getIt(),
          getProfileUseCase: getIt(),
          loginUseCase: getIt(),
          logoutUseCase: getIt(),
          registerUseCase: getIt(),
          updateProfileUseCase: getIt(),
        ))
    ..registerLazySingleton(() => FormAuthBloc())
    ..registerLazySingleton(() => FormAccountBloc());
    
  }

  @override
  Map<String, Route> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;
    return {
      LoginPage.routeName: MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings: settings,
      ),
      RegisterPage.routeName: CupertinoPageRoute(
        builder: (_) => const RegisterPage(),
        settings: settings,
      ),
    };
  }
}
