import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import 'home.dart';

// Global keys for navigation state
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorChatKey = GlobalKey<NavigatorState>(debugLabel: 'shellChat');
final _shellNavigatorFavoriteKey = GlobalKey<NavigatorState>(debugLabel: 'shellFavorite');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

/// Home module routes with bottom navigation
List<RouteBase> homeRoutes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return BlocProvider(
        create: (context) => BottomNavBloc(),
        child: ScaffoldWithNavBar(navigationShell: navigationShell),
      );
    },
    branches: [
      // Home tab
      StatefulShellBranch(
        navigatorKey: _shellNavigatorHomeKey,
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) => noTransitionPage(
              key: state.pageKey,
              child: const Scaffold(
                body: Center(
                  child: Text('Home'),
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Chat tab
      StatefulShellBranch(
        navigatorKey: _shellNavigatorChatKey,
        routes: [
          GoRoute(
            path: '/home/chat',
            name: 'chat',
            pageBuilder: (context, state) => noTransitionPage(
              key: state.pageKey,
              child: const Scaffold(
                body: Center(
                  child: Text('Chat'),
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Favorite tab
      StatefulShellBranch(
        navigatorKey: _shellNavigatorFavoriteKey,
        routes: [
          GoRoute(
            path: '/home/favorite',
            name: 'favorite',
            pageBuilder: (context, state) => noTransitionPage(
              key: state.pageKey,
              child: const Scaffold(
                body: Center(
                  child: Text('Favorite'),
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Profile tab
      StatefulShellBranch(
        navigatorKey: _shellNavigatorProfileKey,
        routes: [
          GoRoute(
            path: '/home/profile',
            name: 'profile',
            pageBuilder: (context, state) => noTransitionPage(
              key: state.pageKey,
              child: const Scaffold(
                body: Center(
                  child: Text('Profile'),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  ),
];

/// Scaffold with bottom navigation bar
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, CartPage.routeName);
        },
        child: const Icon(Icons.shopping_bag_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Dimens.dp16),
        ),
        child: BottomAppBar(
          notchMargin: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
