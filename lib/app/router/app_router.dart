import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/auth/auth.dart';
import '../../features/settings/settings.dart';
import '../modules.dart';
import 'route_utils.dart';

/// The main router for the application
final GoRouter router = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  
  // Redirect logic for authentication
  redirect: (BuildContext context, GoRouterState state) {
    // Get current auth status from BLoC
    final authBloc = GetIt.I<AuthBloc>();
    final isAuthorized = authBloc.state.status == AuthStateStatus.authorized;
    final isUnauthorized = authBloc.state.status == AuthStateStatus.unAuthorized;
    
    final isGoingToLogin = state.matchedLocation == AppRoute.login.path;
    final isGoingToRegister = state.matchedLocation == AppRoute.register.path;
    final isGoingToSplash = state.matchedLocation == '/splash';
    
    // Allow splash screen always
    if (isGoingToSplash) {
      return null;
    }
    
    // If unauthorized and not going to auth pages, redirect to login with return path
    if (isUnauthorized && !isGoingToLogin && !isGoingToRegister) {
      return '${AppRoute.login.path}?redirect=${Uri.encodeComponent(state.matchedLocation)}';
    }
    
    // If authorized and going to login/register, redirect to home
    if (isAuthorized && (isGoingToLogin || isGoingToRegister)) {
      return AppRoute.home.path;
    }
    
    // No redirect needed
    return null;
  },
  
  // Error page builder
  errorBuilder: (context, state) => ErrorPage(
    error: state.error != null ? Exception(state.error.toString()) : null,
  ),
  
  // Routes from modules
  routes: [
    // Splash route (initial route)
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    
    // Aggregate routes from all modules
    ...Modular.routes(),
    
    // Soon page (utility route)
    GoRoute(
      path: AppRoute.soon.path,
      name: AppRoute.soon.name,
      builder: (context, state) {
        final title = (state.extra as Map<String, dynamic>?)?['title'] as String? ?? 'Coming Soon';
        return SoonPage(title: title);
      },
    ),
  ],
  
  // Observers for navigation tracking
  observers: [
    // go_router's built-in observer
    GoRouterObserver(),
  ],
);

/// Custom GoRouter observer for tracking navigation
class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('GoRouter: Pushed ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('GoRouter: Popped ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('GoRouter: Removed ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('GoRouter: Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }
}
