import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../app/config.dart';
import '../../../../../core/core.dart';
import '../../../../auth/auth.dart';

part 'sections/form_section.dart';
part 'sections/image_section.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  static const String routeName = '/profile/edit';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    context.read<FormAccountBloc>().add(InitialFormAccountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, profile) {
        if (profile.status == AuthStateStatus.failure) {
          EasyLoading.showError(
            profile.failure?.message ?? 'Looks like something went wrong!',
          );
        } else if (profile.status == AuthStateStatus.success) {
          Navigator.pop(context);
          EasyLoading.showSuccess('Update profile successfully!');
        }
      },
      builder: (context, profile) {
        return BlocBuilder<FormAccountBloc, FormAccountState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Edit Profile')),
              body: ListView(
                padding: const EdgeInsets.all(Dimens.dp16),
                children: [
                  Column(
                    children: [
                      _ImageSection(key: widget.key, user: profile.user),
                      Dimens.dp16.height,
                    ],
                  ),
                  _FormSection(key: widget.key, user: profile.user),
                  Dimens.dp32.height,
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(Dimens.dp16),
                child: ElevatedButton(
                  onPressed: state.isValid
                      ? () {
                          context.read<AuthBloc>().add(SubmitUpdateProfileEvent(
                                image: state.image,
                                name: state.name.value.isEmpty
                                    ? profile.user?.name
                                    : state.name.value,
                                phone: state.phone.value,
                                username: state.username.value,
                              ));
                        }
                      : null,
                  child: const Text('Update Now'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
