part of '../page.dart';

class _ProductSection extends StatelessWidget {
  const _ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.statusCategory == ProductStateStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(Dimens.dp16),
                child: HeadingText('For You'),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.dp16,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductPage.routeName,
                      arguments: state.products[index].id,
                    );
                  },
                  child: Row(
                    children: [
                      SmartNetworkImage(
                        state.products[index].galleries.first,
                        width: 120,
                        height: 120,
                        radius: BorderRadius.circular(Dimens.dp16),
                        fit: BoxFit.cover,
                      ),
                      Dimens.dp12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegularText(state.products[index].category.name),
                            Dimens.dp6.height,
                            SubTitleText(
                              state.products[index].name,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Dimens.dp6.height,
                            RegularText(
                              state.products[index].price.toIDR(),
                              style: TextStyle(
                                color: context.theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Dimens.dp30.height,
                itemCount: state.products.length,
              ),
              Dimens.dp32.height,
            ],
          );
        } else {
          return _SkeletonProductSection(key: key);
        }
      },
    );
  }
}
