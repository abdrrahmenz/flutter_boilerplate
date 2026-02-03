import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import 'settings.dart';
import 'routes.dart';

class SettingsModule implements BaseModule {
  @override
  Future<void> inject(GetIt getIt) async {
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
      ..registerLazySingleton(
        () => LanguageBloc(
          getLanguageSetting: getIt(),
          saveLanguageSetting: getIt(),
          getSupportedLanguage: getIt(),
        ),
      )
      ..registerLazySingleton(
        () => ThemeBloc(getThemeSetting: getIt(), saveThemeSetting: getIt()),
      );
  }

  @override
  List<RouteBase> routes() {
    return settingsRoutes;
  }

  @override
  List<BlocProvider> blocProviders() {
    return [
      BlocProvider<ThemeBloc>(
        create: (context) => GetIt.I<ThemeBloc>()..add(const ThemeStarted()),
      ),
      BlocProvider<LanguageBloc>(
        create: (context) =>
            GetIt.I<LanguageBloc>()..add(const LanguageStarted()),
      ),
    ];
  }
}
