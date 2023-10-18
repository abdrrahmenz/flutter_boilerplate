import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/auth/auth.dart';
import '../features/home/home.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route<dynamic> route(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings: settings,
      );
    case RegisterPage.routeName:
      return CupertinoPageRoute(
        builder: (_) => const RegisterPage(),
        settings: settings,
      );
    // case EditProfilePage.routeName:
    //   return CupertinoPageRoute(
    //     builder: (_) => const EditProfilePage(),
    //     settings: settings,
    //   );
    // case DetailChatPage.routeName:
    //   return CupertinoPageRoute(
    //     builder: (_) => DetailChatPage(id: settings.arguments as String),
    //     settings: settings,
    //   );
    case MainPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const MainPage(),
        settings: settings,
      );
    // case ProductPage.routeName:
    //   return MaterialPageRoute(
    //     builder: (_) => ProductPage(id: settings.arguments as String),
    //     settings: settings,
    //   );
    // case CartPage.routeName:
    //   return MaterialPageRoute(
    //     builder: (_) => const CartPage(),
    //     settings: settings,
    //   );
    // case SuccessCheckoutPage.routeName:
    //   return MaterialPageRoute(
    //     builder: (_) => const SuccessCheckoutPage(),
    //     settings: settings,
    //   );
    // case CheckoutPage.routeName:
    //   return CupertinoPageRoute(
    //     builder: (_) => const CheckoutPage(),
    //     settings: settings,
    //   );
    // case TransactionPage.routeName:
    //   return CupertinoPageRoute(
    //     builder: (_) => const TransactionPage(),
    //     settings: settings,
    //   );
    default:
      return CupertinoPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}
