import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/route_utils.dart';
import '../../../../../core/core.dart';
import '../../../../auth/auth.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.unAuthorized) {
          context.go(AppRoute.login.path);
        } else if (state.status == AuthStateStatus.authorized) {
          context.go(AppRoute.home.path);
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
