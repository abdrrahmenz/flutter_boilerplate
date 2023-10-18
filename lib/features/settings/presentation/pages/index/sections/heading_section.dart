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
              fit: BoxFit.cover,
            ),
            Dimens.dp12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingText('Hallo, ${state.user?.name}'),
                  RegularText('@${state.user?.username}'),
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
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(Dimens.dp16),
          backgroundColor: context.theme.canvasColor,
          surfaceTintColor: context.theme.canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          title: const SubTitleText(
            'Are you sure sign out?',
            align: TextAlign.center,
          ),
          content: RegularText.normalSolid(
            context,
            'You will be logged out of this account, but we can login again.',
            align: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
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
