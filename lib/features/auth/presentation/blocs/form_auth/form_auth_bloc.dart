import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../auth.dart';

part 'form_auth_event.dart';
part 'form_auth_state.dart';

class FormAuthBloc extends Bloc<FormAuthEvent, FormAuthState> {
  FormAuthBloc() : super(FormAuthState.initial()) {
    on<InitialFormAuthEvent>((event, emit) {
      emit(FormAuthState.initial());
    });

    on<ChangeEmailFormAuthEvent>((event, emit) {
      final email = EmailFormZ.dirty(event.email);
      emit(state.copyWith(email: email));
    });

    on<ChangePasswordFormAuthEvent>((event, emit) {
      final password = PasswordFormZ.dirty(event.password);
      emit(state.copyWith(password: password));
    });

    on<ChangeNameFormAuthEvent>((event, emit) {
      final name = NameFormZ.dirty(event.name);
      emit(state.copyWith(name: name));
    });

    on<ChangeUsernameFormAuthEvent>((event, emit) {
      final username = NameFormZ.dirty(event.username);
      emit(state.copyWith(username: username));
    });

    on<ChangeEmailRegisterFormAuthEvent>((event, emit) {
      final email = EmailFormZ.dirty(event.email);
      emit(state.copyWith(emailRegister: email));
    });

    on<ChangePasswordRegisterFormAuthEvent>((event, emit) {
      final password = PasswordFormZ.dirty(event.password);
      emit(state.copyWith(passwordRegister: password));
    });
  }
}
