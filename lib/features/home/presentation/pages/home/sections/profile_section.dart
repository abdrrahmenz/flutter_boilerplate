part of '../page.dart';

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.dp16,
        vertical: Dimens.dp42,
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingText('Hallo, ${state.user?.name}'),
                    RegularText('@${state.user?.username}'),
                  ],
                ),
              ),
              SmartNetworkImage(
                state.user?.image ?? AppConfig.profileUrl,
                width: 54,
                height: 54,
                radius: BorderRadius.circular(Dimens.dp100),
                fit: BoxFit.cover,
              ),
            ],
          );
        },
      ),
    );
  }
}
