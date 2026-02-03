part of '../page.dart';

class _FormSection extends StatelessWidget {
  const _FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.authorized) {
          EasyLoading.dismiss();
          context.go(AppRoute.home.path);
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
              (Dimens.height(context) / 12).height,
              ShadTextInput(
                label: 'Full Name',
                prefixIcon: Icons.person,
                hintText: 'Your Full Name',
                onChange: (v) {
                  context.read<FormAuthBloc>().add(ChangeNameFormAuthEvent(v));
                },
                errorText:
                    state.name.isNotValid ? 'Please enter a valid name.' : null,
              ),
              Dimens.dp16.height,
              ShadTextInput(
                label: 'Username',
                prefixIcon: Icons.account_circle_rounded,
                hintText: 'Your Username',
                onChange: (v) {
                  context
                      .read<FormAuthBloc>()
                      .add(ChangeUsernameFormAuthEvent(v));
                },
                errorText: state.username.isNotValid
                    ? 'Please enter a valid username.'
                    : null,
              ),
              Dimens.dp16.height,
              ShadTextInput(
                label: 'Email Address',
                prefixIcon: Icons.email_rounded,
                hintText: 'Your Email Address',
                onChange: (v) {
                  context
                      .read<FormAuthBloc>()
                      .add(ChangeEmailRegisterFormAuthEvent(v));
                },
                errorText: state.emailRegister.isNotValid
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
                      .add(ChangePasswordRegisterFormAuthEvent(v));
                },
                errorText: state.passwordRegister.isNotValid
                    ? 'Please enter a valid password.'
                    : null,
              ),
              Dimens.dp32.height,
              ShadButton(
                width: double.infinity,
                onPressed: state.isValidRegister
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(
                              SubmitRegisterEvent(
                                email: state.emailRegister.value,
                                password: state.passwordRegister.value,
                                name: state.name.value,
                                username: state.username.value.toLowerCase(),
                              ),
                            );
                      }
                    : null,
                child: const Text('Sign Up'),
              ),
              Dimens.dp32.height,
            ],
          );
        },
      ),
    );
  }
}
