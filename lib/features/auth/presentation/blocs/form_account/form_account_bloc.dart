import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../auth.dart';

part 'form_account_event.dart';
part 'form_account_state.dart';

class FormAccountBloc extends Bloc<FormAccountEvent, FormAccountState> {
  FormAccountBloc() : super(FormAccountState.initial()) {
    on<InitialFormAccountEvent>((event, emit) {
      emit(FormAccountState.initial());
    });

    on<ChangeNameFormAccountEvent>((event, emit) {
      final name = NameFormZ.dirty(event.name);
      emit(state.copyWith(name: name));
    });

    on<ChangeUsernameFormAccountEvent>((event, emit) {
      final username = NameFormZ.dirty(event.username);
      emit(state.copyWith(username: username));
    });

    on<ChangePhoneFormAccountEvent>((event, emit) {
      final phone = PhoneFormZ.dirty(event.phone);
      emit(state.copyWith(phone: phone));
    });

    on<ChangeImageFormAccountEvent>((event, emit) async {
      final picker = ImagePicker();
      final image = event.isGallery
          ? await picker.pickImage(source: ImageSource.gallery)
          : await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        emit(state.copyWith(image: File(image.path)));
      }
    });
  }
}
