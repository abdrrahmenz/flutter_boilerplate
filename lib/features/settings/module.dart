import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import 'settings.dart';

class SettingsModule implements BaseModule {
  @override
  Future inject(GetIt getIt) async {
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

  @override
  Map<String, Route> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;
    return {
      // ProfilePage.routeName: CupertinoPageRoute(
      //   builder: (_) => const ProfilePage(),
      //   settings: settings,
      // ),
      // FAQDetailPage.routeName: CupertinoPageRoute(
      //   builder: (_) => FAQDetailPage(data: args['data']),
      //   settings: settings,
      // ),
      // HelpDetailPage.routeName: CupertinoPageRoute(
      //   builder: (_) => HelpDetailPage(data: args['data']),
      //   settings: settings,
      // ),
      // default:
      //   return CupertinoPageRoute(builder: (_) {
      //     return const Scaffold(
      //       body: Center(
      //         child: Text('Page not found :('),
      //       ),
      //     );
      //   });
    };
  }
}
