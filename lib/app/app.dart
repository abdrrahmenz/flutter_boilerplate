import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/core.dart';
import '../features/settings/settings.dart';
import '../l10n/app_localizations.dart';
import 'config.dart';
import 'modules.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Modular.withBlocProviders(_AppWidget(key: key));
  }
}

class _AppWidget extends StatefulWidget {
  const _AppWidget({Key? key});

  @override
  State<_AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<_AppWidget> {
  @override
  void initState() {
    EasyLoading.instance
      ..indicatorType = .fadingCircle
      ..loadingStyle = .custom
      ..maskType = .black
      ..radius = Dimens.dp8
      ..backgroundColor = AppColors.white
      ..indicatorColor = AppColors.red
      ..textColor = AppColors.black
      ..userInteractions = false
      ..toastPosition = .bottom
      ..animationStyle = .offset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final themeState = context.watch<ThemeBloc>().state;

    return MaterialApp(
      title: AppConfig.appName,
      navigatorKey: navigationKey,
      theme: themeState.theme.toThemeData(),
      locale: languageState.language != null
          ? Locale(languageState.language!.code)
          : null,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [routeObserver],
      onGenerateRoute: Modular.routes,
      home: const SplashPage(),
      builder: EasyLoading.init(),
    );
  }
}
