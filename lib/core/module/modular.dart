
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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

  /// Aggregate routes from all modules for go_router.
  static List<RouteBase> routes() {
    final allRoutes = <RouteBase>[];

    for (var item in modulesX) {
      allRoutes.addAll(item.routes());
    }

    return allRoutes;
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
