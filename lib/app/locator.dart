import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../core/core.dart';

import 'config.dart';
import 'modules.dart';

final getIt = GetIt.instance;
Future<void> setupLocator() async {
  await _setupCore();

  await Modular.init(appModules, GetIt.instance);
}

Future<void> _setupCore() async {
  EquatableConfig.stringify = AppConfig.autoStringifyEquatable;

  getIt.registerLazySingleton(Connectivity.new);
  getIt.registerLazySingleton(CaptureErrorUseCase.new);
  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(baseUrl: AppConfig.baseUrl.value)
      ..interceptors.addAll([
        LogInterceptor(requestBody: true, responseBody: true),
        AuthHttpInterceptor(authLocalSource: getIt(), onUnAuth: () {}),
      ]),
  );

  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init('${appDocDir.path}/db');
  }

  getIt.registerLazySingleton<HiveInterface>(() => Hive);

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );
}
