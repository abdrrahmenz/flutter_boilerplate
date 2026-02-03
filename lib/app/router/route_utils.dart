/// Enum defining all application routes
enum AppRoute {
  /// Authentication routes
  login,
  register,

  /// Main app routes
  home,
  
  /// Settings routes
  profileEdit,
  
  /// Utility routes
  soon,
}

/// Extension to get route paths from enum
extension AppRouteX on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.login:
        return '/login';
      case AppRoute.register:
        return '/register';
      case AppRoute.home:
        return '/home';
      case AppRoute.profileEdit:
        return '/profile/edit';
      case AppRoute.soon:
        return '/soon';
    }
  }
  
  String get name {
    switch (this) {
      case AppRoute.login:
        return 'login';
      case AppRoute.register:
        return 'register';
      case AppRoute.home:
        return 'home';
      case AppRoute.profileEdit:
        return 'profile-edit';
      case AppRoute.soon:
        return 'soon';
    }
  }
}
