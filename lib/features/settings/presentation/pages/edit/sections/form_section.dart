part of '../page.dart';

class _FormSection extends StatefulWidget {
  const _FormSection({super.key, required this.user});
  final User? user;

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    setState(() {
      nameController.text = widget.user?.name ?? '';
      usernameController.text = widget.user?.username ?? '';
      phoneController.text = widget.user?.phone ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormAccountBloc, FormAccountState>(
      builder: (context, state) {
        return Column(
          children: [
            RegularInput(
              controller: nameController,
              label: 'Name',
              hintText: 'Your name',
              onChange: (v) {
                context
                    .read<FormAccountBloc>()
                    .add(ChangeNameFormAccountEvent(v));
              },
              errorText: state.name.isNotValid ? 'Please enter a name.' : null,
            ),
            Dimens.dp16.height,
            RegularInput(
              controller: usernameController,
              label: 'Username',
              hintText: 'Your username',
              onChange: (v) {
                context
                    .read<FormAccountBloc>()
                    .add(ChangeUsernameFormAccountEvent(v));
              },
              errorText:
                  state.username.isNotValid ? 'Please enter a username.' : null,
            ),
            Dimens.dp16.height,
            RegularInput(
              controller: TextEditingController(text: widget.user?.email),
              label: 'Email Address',
              hintText: 'Your email address',
              readOnly: true,
            ),
            Dimens.dp16.height,
            RegularInput(
              controller: phoneController,
              label: 'Phone Number',
              hintText: 'Your phone number',
              onChange: (v) {
                context
                    .read<FormAccountBloc>()
                    .add(ChangePhoneFormAccountEvent(v));
              },
              errorText: state.phone.isNotValid
                  ? 'Please enter a phone number.'
                  : null,
              inputType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
