part of '../page.dart';

class _FormSection extends StatelessWidget {
  const _FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.authorized) {
          EasyLoading.dismiss();
          // Check for redirect parameter
          final uri = GoRouterState.of(context).uri;
          final redirect = uri.queryParameters['redirect'];
          if (redirect != null && redirect.isNotEmpty) {
            context.go(redirect);
          } else {
            context.go(AppRoute.home.path);
          }
        } else if (state.status == AuthStateStatus.loading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state.status == AuthStateStatus.unAuthorized) {
          EasyLoading.showError(
            state.failure?.message ?? 'Looks like something went wrong!',
          );
        }
      },
      child: BlocBuilder<FormAuthBloc, FormAuthState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              (Dimens.height(context) / 10).height,
              ShadTextInput(
                label: 'Email Address',
                prefixIcon: Icons.email_rounded,
                hintText: 'Your Email Address',
                onChange: (v) {
                  context.read<FormAuthBloc>().add(ChangeEmailFormAuthEvent(v));
                },
                errorText: state.email.isNotValid
                    ? 'Please enter a valid email address.'
                    : null,
                inputType: TextInputType.emailAddress,
              ),
              Dimens.dp16.height,
              ShadPasswordInput(
                label: 'Password',
                hintText: 'Your Password',
                onChange: (v) {
                  context
                      .read<FormAuthBloc>()
                      .add(ChangePasswordFormAuthEvent(v));
                },
                errorText: state.password.isNotValid
                    ? 'Please enter a valid password.'
                    : null,
              ),
              Dimens.dp32.height,
              ShadButton(
                width: double.infinity,
                onPressed: state.isValid
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(SubmitLoginEvent(
                              email: state.email.value,
                              password: state.password.value,
                            ));
                      }
                    : null,
                child: const Text('Sign In'),
              ),
              Dimens.dp32.height,
            ],
          );
        },
      ),
    );
  }
}
