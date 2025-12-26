import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import '../../../../auth/auth.dart';
import '../../../../home/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.unAuthorized) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.routeName,
            (route) => false,
          );
        } else if (state.status == AuthStateStatus.authorized) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainPage.routeName,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            MainAssets.logoImg,
            width: Dimens.width(context) / 2,
          ),
        ),
      ),
    );
  }
}
