part of '../page.dart';

class _ImageSection extends StatefulWidget {
  const _ImageSection({super.key, required this.user});
  final User? user;

  @override
  State<_ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<_ImageSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormAccountBloc, FormAccountState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            show();
          },
          child: state.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.dp100),
                  child: Image.file(
                    state.image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : SmartNetworkImage(
                  widget.user?.image ?? AppConfig.profileUrl,
                  width: 100,
                  height: 100,
                  radius: BorderRadius.circular(Dimens.dp100),
                  fit: BoxFit.cover,
                ),
        );
      },
    );
  }

  void show() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(Dimens.dp16),
          backgroundColor: context.theme.canvasColor,
          surfaceTintColor: context.theme.canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dp16),
          ),
          contentPadding: const EdgeInsets.all(Dimens.dp16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<FormAccountBloc>()
                      .add(const ChangeImageFormAccountEvent());
                },
                child: RegularText.mediumSolid(context, 'Camera'),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<FormAccountBloc>().add(
                        const ChangeImageFormAccountEvent(isGallery: true),
                      );
                },
                child: RegularText.mediumSolid(context, 'Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }
}
