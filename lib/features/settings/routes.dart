import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import 'settings.dart';

/// Settings module routes
List<RouteBase> settingsRoutes = [
  GoRoute(
    path: EditProfilePage.routeName,
    name: 'profile-edit',
    pageBuilder: (context, state) {
      return cupertinoPage(
        key: state.pageKey,
        child: const EditProfilePage(),
      );
    },
  ),
];
