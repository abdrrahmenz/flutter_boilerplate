import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../app/router/route_utils.dart';
import '../../../../../core/core.dart';
import '../../../auth.dart';

part 'sections/form_section.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(Dimens.dp16),
        children: [
          Dimens.dp24.height,
          Text('Sign Up', style: context.h3),
          Text('Register and Happy Shoping', style: context.bodyMedium),
          _FormSection(key: key),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Already have an account?',
            style: context.theme.textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: ' Sign In',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
