part of '../page.dart';

class _HeadingSection extends StatefulWidget {
  const _HeadingSection({super.key});

  @override
  State<_HeadingSection> createState() => _HeadingSectionState();
}

class _HeadingSectionState extends State<_HeadingSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          children: [
            SmartNetworkImage(
              state.user?.image ?? AppConfig.profileUrl,
              width: 64,
              height: 64,
              radius: BorderRadius.circular(Dimens.dp100),
              fit: .cover,
            ),
            Dimens.dp12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('Hallo, ${state.user?.name}', style: context.h3),
                  Text('@${state.user?.username}', style: context.bodyMedium),
                ],
              ),
            ),
            Dimens.dp12.width,
            GestureDetector(
              onTap: () {
                showConfirm();
              },
              child: Icon(
                Icons.logout,
                color: context.theme.colorScheme.error,
              ),
            ),
          ],
        );
      },
    );
  }

  void showConfirm() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(Dimens.dp16),
          backgroundColor: context.theme.canvasColor,
          surfaceTintColor: context.theme.canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          title: Text(
            'Are you sure sign out?',
            style: context.subtitle1,
            textAlign: .center,
          ),
          content: Text(
            'You will be logged out of this account, but we can login again.',
            style: context.bodyMedium,
            textAlign: .center,
          ),
          actionsAlignment: .center,
          actions: [
            ButtonActionConfirm(
              onCancel: () {
                Navigator.pop(context);
              },
              onConfirm: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
