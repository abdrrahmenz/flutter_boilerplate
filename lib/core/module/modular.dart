
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../core.dart';

/// Class responsible for modularizing the application.
class Modular {
  static List<BaseModule> modulesX = [];

  /// Initialize the modular setup with the provided modules and dependency injector.
  ///
  /// This method should be called at the beginning of the application to set up all modules and dependencies.
  static Future<void> init(List<BaseModule> modules, GetIt sl) async {
    modulesX = modules;

    for (var item in modules) {
      await item.inject(sl);
    }
  }

  /// Define routes for the application based on the modules.
  static Route<dynamic> routes(RouteSettings settings) {
    // List all routes module
    final routeModules = <String, Route<dynamic>>{};

    for (var item in modulesX) {
      routeModules.addAll(item.routes(settings));
    }

    if (settings.name == SoonPage.routeName) {
      return MaterialPageRoute(builder: (_) {
        return SoonPage(
          title: (settings.arguments as Map<String, dynamic>)['title'] as String,
        );
      });
    }
    return routeModules['${settings.name}'] ??
        MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
  }

  /// Wrap the application with all BlocProviders from modules.
  static Widget withBlocProviders(Widget app) {
    final allBlocProviders =
        modulesX.expand((module) => module.blocProviders()).toList();

    return MultiBlocProvider(
      providers: allBlocProviders,
      child: app,
    );
  }
}
