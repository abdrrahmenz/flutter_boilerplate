part of '../page.dart';

class _CategorySection extends StatelessWidget {
  const _CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Dimens.dp8),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(Dimens.dp12),
                    onTap: () {
                      context
                          .read<CategoryBloc>()
                          .add(const SelectCategoryEvent(''));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(Dimens.dp8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.dp12,
                        vertical: Dimens.dp10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            state.id == '' ? context.theme.primaryColor : null,
                        borderRadius: BorderRadius.circular(Dimens.dp12),
                        border: Border.all(
                            color: state.id == ''
                                ? context.theme.primaryColor
                                : context.theme.dividerColor),
                      ),
                      child: state.id == ''
                          ? RegularText.mediumSolid(context, 'All Shoes')
                          : const RegularText('All Shoes'),
                    ),
                  ),
                  ...state.categories
                      .map(
                        (e) => InkWell(
                          borderRadius: BorderRadius.circular(Dimens.dp12),
                          onTap: () {
                            context
                              ..read<CategoryBloc>()
                                  .add(SelectCategoryEvent(e.id))
                              ..read<ProductBloc>()
                                  .add(GetCategoryProductEvent(e.id));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(Dimens.dp8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.dp12,
                              vertical: Dimens.dp10,
                            ),
                            decoration: BoxDecoration(
                              color: state.id == e.id
                                  ? context.theme.primaryColor
                                  : null,
                              borderRadius: BorderRadius.circular(Dimens.dp12),
                              border: Border.all(
                                  color: state.id == e.id
                                      ? context.theme.primaryColor
                                      : context.theme.dividerColor),
                            ),
                            child: state.id == e.id
                                ? RegularText.mediumSolid(context, e.name)
                                : RegularText(e.name),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
