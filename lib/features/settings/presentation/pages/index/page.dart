import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../app/config.dart';
import '../../../../../core/core.dart';
import '../../../../auth/auth.dart';
import '../../../settings.dart';

part 'sections/heading_section.dart';
part 'sections/account_section.dart';
part 'sections/general_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.unAuthorized) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.routeName,
            (route) => false,
          );
        } else if (state.status == AuthStateStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        }
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(Dimens.dp16),
          children: [
            Dimens.dp24.height,
            _HeadingSection(key: key),
            Dimens.dp42.height,
            _AccountSection(key: key),
            Dimens.dp42.height,
            const _GeneralSection(),
            Dimens.dp42.height,
          ],
        ),
      ),
    );
  }
}
