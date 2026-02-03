import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import 'home.dart';
import 'routes.dart';

class HomeModule implements BaseModule {
  @override
  Future<void> inject(GetIt getIt) async {
    // Data

    // Domain

    // Presentation
     getIt.registerLazySingleton(() => BottomNavBloc());
    
  }

  @override
  List<RouteBase> routes() {
    return homeRoutes;
  }

  @override
  List<BlocProvider> blocProviders() {
    return [
      
    ];
  }
}
