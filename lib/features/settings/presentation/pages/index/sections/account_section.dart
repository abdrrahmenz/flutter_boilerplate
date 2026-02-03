part of '../page.dart';

class _AccountSection extends StatelessWidget {
  const _AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitleText('Account'),
        Dimens.dp16.height,
        _tile('Edit Profile', onTap: () {
          context.push(AppRoute.profileEdit.path);
        }),
        _tile('Your Orders', onTap: () {
          // Navigator.pushNamed(context, TransactionPage.routeName);
        }),
        _tile('Help', onTap: () {
          context.push(
            AppRoute.soon.path,
            extra: {'title': 'Help'},
          );
        }),
      ],
    );
  }

  Widget _tile(String title, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.dp12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText(title),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}
