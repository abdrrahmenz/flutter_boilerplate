import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import '../core/core.dart';
import '../features/auth/auth.dart';
import '../features/settings/settings.dart';
import '../l10n/l10n.dart';
import 'config.dart';
import 'route.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            AppConfig.transparentStatusBar ? Colors.transparent : null,
        statusBarIconBrightness: AppConfig.defaultTheme == AppTheme.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<ThemeBloc>()..add(const ThemeStarted()),
        ),
        BlocProvider(
          create: (context) =>
              GetIt.I<LanguageBloc>()..add(const LanguageStarted()),
        ),
        BlocProvider(create: (context) => GetIt.I<FormAuthBloc>()),
        BlocProvider(create: (context) => GetIt.I<FormAccountBloc>()),
        BlocProvider(
          create: (context) => GetIt.I<AuthBloc>()..add(GetProfileEvent()),
        ),
        // BlocProvider(create: (context) => GetIt.I<CategoryBloc>()),
        // BlocProvider(create: (context) => GetIt.I<ProductBloc>()),
        // BlocProvider(create: (context) => GetIt.I<DetailProductBloc>()),
        // BlocProvider(create: (context) => GetIt.I<FavoriteBloc>()),
        // BlocProvider(create: (context) => GetIt.I<AddCartBloc>()),
        // BlocProvider(create: (context) => GetIt.I<CartBloc>()),
        // BlocProvider(create: (context) => GetIt.I<CheckoutBloc>()),
        // BlocProvider(create: (context) => GetIt.I<TransactionBloc>()),
        // BlocProvider(create: (context) => GetIt.I<CreateRoomBloc>()),
        // BlocProvider(create: (context) => GetIt.I<RoomBloc>()),
        // BlocProvider(create: (context) => GetIt.I<ChatBloc>()),
      ],
      child: const _AppWidget(),
    );
  }
}

class _AppWidget extends StatelessWidget {
  const _AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final themeState = context.watch<ThemeBloc>().state;

    return MaterialApp(
      title: AppConfig.appName,
      theme: themeState.theme.toThemeData(),
      locale: languageState.language != null
          ? Locale(languageState.language!.code)
          : null,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: [routeObserver],
      onGenerateRoute: route,
      home: const SplashPage(),
      builder: EasyLoading.init(),
    );
  }
}
