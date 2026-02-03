import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import 'auth.dart';

/// Auth module routes
List<RouteBase> authRoutes = [
  GoRoute(
    path: LoginPage.routeName,
    name: 'login',
    pageBuilder: (context, state) {
      return materialPage(
        key: state.pageKey,
        child: const LoginPage(),
      );
    },
  ),
  GoRoute(
    path: RegisterPage.routeName,
    name: 'register',
    pageBuilder: (context, state) {
      return cupertinoPage(
        key: state.pageKey,
        child: const RegisterPage(),
      );
    },
  ),
];
