
import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../features/auth/module.dart';
import '../features/home/module.dart';
import '../features/settings/module.dart';

/// Global key for accessing the application's navigator state.
final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

/// Route observer to observe route changes.
final RouteObserver<ModalRoute<dynamic>> routeObserver = RouteObserver<ModalRoute<dynamic>>();

/// List of modules to be initialized in the application.
var appModules = <BaseModule>[
  AuthModule(),
  SettingsModule(),
  HomeModule(),
  // PaymentModule(),
  // FeeModule(),
];
