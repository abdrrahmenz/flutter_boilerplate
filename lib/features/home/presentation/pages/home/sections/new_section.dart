part of '../page.dart';

class _NewSection extends StatelessWidget {
  const _NewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStateStatus.success &&
            state.newProducts.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(Dimens.dp16),
                child: HeadingText('New Arrival'),
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
                      arguments: state.newProducts[index].id,
                    );
                  },
                  child: Row(
                    children: [
                      SmartNetworkImage(
                        state.newProducts[index].galleries.first,
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
                            RegularText(state.newProducts[index].category.name),
                            Dimens.dp6.height,
                            SubTitleText(
                              state.newProducts[index].name,
                              maxLine: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Dimens.dp6.height,
                            RegularText(
                              state.newProducts[index].price.toIDR(),
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
                itemCount: state.newProducts.length,
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
