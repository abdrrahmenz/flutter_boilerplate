part of '../page.dart';

class _SkeletonProductSection extends StatelessWidget {
  const _SkeletonProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimens.dp16),
            child: Skeleton(width: Dimens.dp150, height: Dimens.dp22),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.dp16,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
              children: [
                const Skeleton(width: 120, height: 120, radius: 16),
                Dimens.dp12.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skeleton(width: Dimens.dp100, height: Dimens.dp14),
                    Dimens.dp6.height,
                    const Skeleton(width: Dimens.dp200, height: Dimens.dp18),
                    Dimens.dp6.height,
                    const Skeleton(width: Dimens.dp200, height: Dimens.dp18),
                    Dimens.dp6.height,
                    const Skeleton(width: Dimens.dp150, height: Dimens.dp14),
                  ],
                ),
              ],
            ),
            separatorBuilder: (context, index) => Dimens.dp30.height,
            itemCount: 3,
          ),
          Dimens.dp32.height,
        ],
      ),
    );
  }
}
