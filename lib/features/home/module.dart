import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import 'home.dart';

class HomeModule implements BaseModule {
  @override
  Future<void> inject(GetIt getIt) async {
    // Data

    // Domain

    // Presentation
     getIt.registerLazySingleton(() => BottomNavBloc());
    
  }

  @override
  Map<String, Route<dynamic>> routes(RouteSettings settings) {
    // final args = (settings.arguments ?? {}) as Map;
    return {
      // LoginPage.routeName: MaterialPageRoute(
      //   builder: (_) => const LoginPage(),
      //   settings: settings,
      // ),
      // RegisterPage.routeName: CupertinoPageRoute(
      //   builder: (_) => const RegisterPage(),
      //   settings: settings,
      // ),
    };
  }

  @override
  List<BlocProvider> blocProviders() {
    return [
      
    ];
  }
}
