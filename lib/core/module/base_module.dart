import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Base class for module implementation.
///
/// Every module should implement:
///
/// - Dependency Injection
/// - Routing
///
abstract class BaseModule {
  /// Define routes for your module using go_router.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// [
  ///   GoRoute(
  ///     path: '/home',
  ///     builder: (context, state) => HomePage(),
  ///   ),
  ///   GoRoute(
  ///     path: '/auth',
  ///     builder: (context, state) => AuthPage(),
  ///   ),
  /// ]
  /// ```
  List<RouteBase> routes();

  /// Inject all dependencies.
  ///
  /// This method should register all necessary dependencies using the provided [getIt].
  Future<void> inject(GetIt getIt);

  /// Provide BlocProviders for your module.
  ///
  /// Example:
  /// ```dart
  /// [
  ///   BlocProvider(create: (_) => MyBloc()),
  /// ]
  /// ```
  List<BlocProvider> blocProviders();
}
