import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../core/core.dart';

import '../features/auth/auth.dart';
import '../features/settings/settings.dart';
import 'config.dart';

final getIt = GetIt.instance;
Future<void> setupLocator() async {
  await _setupCore();

  // ------------------------------ Authentication ---------------------------------

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

  // ------------------------------ Product & Category ---------------------------------

  // Data
  // getIt
  //   ..registerLazySingleton<ProductApiSource>(
  //         () => ProductApiSourceImpl(getIt()),
  //   )
  //   ..registerLazySingleton<ProductRepository>(
  //         () => ProductRepositoryImpl(getIt()),
  //   );

  // Domain
  // getIt
  //   ..registerLazySingleton(() => GetCategoriesUseCase(getIt()))
  //   ..registerLazySingleton(() => GetProductsByCategoryUseCase(getIt()))
  //   ..registerLazySingleton(() => GetProductUseCase(getIt()))
  //   ..registerLazySingleton(() => GetProductsUseCase(getIt()));

  // Presentation
  // getIt
  //   ..registerLazySingleton(
  //         () => CategoryBloc(getCategoriesUseCase: getIt()),
  //   )
  //   ..registerLazySingleton(
  //         () => ProductBloc(
  //       getProductsByCategoryUseCase: getIt(),
  //       getProductsUseCase: getIt(),
  //     ),
  //   )
  //   ..registerLazySingleton(
  //         () => DetailProductBloc(
  //       getProductUseCase: getIt(),
  //       checkProductFavoriteUseCase: getIt(),
  //       actionProductFavoriteUseCase: getIt(),
  //     ),
  //   );

  // ------------------------------ Favorite ---------------------------------

  // Data
  // getIt
  //   ..registerLazySingleton<FavoriteApiSource>(
  //         () => FavoriteApiSourceImpl(getIt()),
  //   )
  //   ..registerLazySingleton<FavoriteRepository>(
  //         () => FavoriteRepositoryImpl(getIt()),
  //   );

  // Domain
  // getIt
  //   ..registerLazySingleton(() => CheckProductFavoriteUseCase(getIt()))
  //   ..registerLazySingleton(() => ActionProductFavoriteUseCase(getIt()))
  //   ..registerLazySingleton(() => GetProductFavoritesUseCase(getIt()));

  // Presentation
  // getIt.registerLazySingleton(
  //       () => FavoriteBloc(
  //     actionProductFavoriteUseCase: getIt(),
  //     getProductFavoritesUseCase: getIt(),
  //   ),
  // );

  // ------------------------------ Cart ---------------------------------

  // Data
  // getIt
  //   ..registerLazySingleton<CartApiSource>(
  //         () => CartApiSourceImpl(getIt()),
  //   )
  //   ..registerLazySingleton<CartRepository>(
  //         () => CartRepositoryImpl(getIt()),
  //   );

  // Domain
  // getIt
  //   ..registerLazySingleton(() => AddCartUseCase(getIt()))
  //   ..registerLazySingleton(() => GetCartsUseCase(getIt()))
  //   ..registerLazySingleton(() => IncrementCartUseCase(getIt()))
  //   ..registerLazySingleton(() => DecrementCartUseCase(getIt()))
  //   ..registerLazySingleton(() => DeleteCartUseCase(getIt()));

  // Presentation
  // getIt
  //   ..registerLazySingleton(() => AddCartBloc(addCartUseCase: getIt()))
  //   ..registerLazySingleton(() => CartBloc(
  //     decrementCartUseCase: getIt(),
  //     deleteCartUseCase: getIt(),
  //     getCartsUseCase: getIt(),
  //     incrementCartUseCase: getIt(),
  //   ));

  // ------------------------------ Transaction ---------------------------------

  // Data
  // getIt
  //   ..registerLazySingleton<TransactionApiSource>(
  //         () => TransactionApiSourceImpl(getIt()),
  //   )
  //   ..registerLazySingleton<TransactionRepository>(
  //         () => TransactionRepositoryImpl(getIt()),
  //   );

  // Domain
  // getIt
  //   ..registerLazySingleton(() => CreateTransactionUseCase(getIt()))
  //   ..registerLazySingleton(() => GetTransactionsUseCase(getIt()));

  // Presentation
  // getIt
  //   ..registerLazySingleton(
  //         () => CheckoutBloc(createTransactionUseCase: getIt()),
  //   )
  //   ..registerLazySingleton(
  //         () => TransactionBloc(getTransactionsUseCase: getIt()),
  //   );

  // ------------------------------ Chat ---------------------------------

  // Data
  // getIt
  //   ..registerLazySingleton<ChatApiSource>(
  //         () => ChatApiSourceImpl(getIt()),
  //   )
  //   ..registerLazySingleton<ChatRepository>(
  //         () => ChatRepositoryImpl(getIt()),
  //   );

  // Domain
  // getIt
  //   ..registerLazySingleton(() => CreateRoomUseCase(getIt()))
  //   ..registerLazySingleton(() => GetMessagesUseCase(getIt()))
  //   ..registerLazySingleton(() => SendMessageUseCase(getIt()))
  //   ..registerLazySingleton(() => GetRoomsUseCase(getIt()));

  // Presentation
  // getIt
  //   ..registerLazySingleton(
  //         () => CreateRoomBloc(createRoomUseCase: getIt()),
  //   )
  //   ..registerLazySingleton(
  //         () => ChatBloc(getMessagesUseCase: getIt(), sendMessageUseCase: getIt()),
  //   )
  //   ..registerLazySingleton(() => RoomBloc(getRoomsUseCase: getIt()));

  // ------------------------------ Settings ---------------------------------

  // Data
  getIt
    ..registerLazySingleton<SettingsLocalSource>(
      () => SettingsLocalSourceImpl(getIt()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localSource: getIt()),
    );

  // Domain
  getIt
    ..registerLazySingleton(() => GetLanguageSettingUseCase(getIt()))
    ..registerLazySingleton(() => GetSettingsUseCase(getIt()))
    ..registerLazySingleton(() => GetThemeSettingUseCase(getIt()))
    ..registerLazySingleton(() => SaveLanguageSettingUseCase(getIt()))
    ..registerLazySingleton(() => SaveSettingsUseCase(getIt()))
    ..registerLazySingleton(() => SaveThemeSettingUseCase(getIt()))
    ..registerLazySingleton(GetSupportedLanguageUseCase.new)
    ..registerLazySingleton(RecordErrorUseCase.new)
    ..registerLazySingleton(GetOnboardingDataUseCase.new)
    ..registerLazySingleton(() => SetDoneOnboardingUseCase(getIt()))
    ..registerLazySingleton(() => GetOnboardingStatusUseCase(getIt()));

  // Presentation
  getIt
    ..registerFactory(
      () => LanguageBloc(
        getLanguageSetting: getIt(),
        saveLanguageSetting: getIt(),
        getSupportedLanguage: getIt(),
      ),
    )
    ..registerFactory(
      () => ThemeBloc(
        getThemeSetting: getIt(),
        saveThemeSetting: getIt(),
      ),
    );
}

Future<void> _setupCore() async {
  EquatableConfig.stringify = AppConfig.autoStringifyEquatable;

  getIt.registerLazySingleton(Connectivity.new);
  getIt.registerLazySingleton(
    () => CaptureErrorUseCase(),
  );
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
