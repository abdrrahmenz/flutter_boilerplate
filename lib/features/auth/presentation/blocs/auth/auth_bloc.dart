import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.changePasswordUseCase,
    required this.getProfileUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
    required this.updateProfileUseCase,
  }) : super(AuthState.initial()) {
    on<GetProfileEvent>(
      (event, emit) async {
        try {
          final usecase = await getProfileUseCase(const NoParams());
          usecase.fold(
            (l) {
              emit(state.copyWith(
                failure: l,
                status: .unAuthorized,
              ));
            },
            (r) {
              emit(state.copyWith(
                user: r,
                status: .authorized,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
      transformer: debounce(const Duration(seconds: 1)),
    );

    on<SubmitLoginEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: .loading));
          final usecase = await loginUseCase(LoginParams(
            email: event.email,
            password: event.password,
          ));
          usecase.fold(
            (l) {
              emit(state.copyWith(
                failure: l,
                status: .unAuthorized,
              ));
            },
            (r) {
              emit(state.copyWith(
                user: r,
                status: .authorized,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
    );

    on<SubmitRegisterEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: .loading));
          final usecase = await registerUseCase(RegisterParams(
            name: event.name,
            username: event.username,
            email: event.email,
            password: event.password,
          ));
          usecase.fold(
            (l) {
              emit(state.copyWith(
                failure: l,
                status: .unAuthorized,
              ));
            },
            (r) {
              emit(state.copyWith(
                user: r,
                status: .authorized,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
    );

    on<SubmitUpdateProfileEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: .loading));
          final usecase = await updateProfileUseCase(UpdateProfileParams(
            name: event.name,
            username: event.username,
            image: event.image,
            phone: event.phone,
          ));
          usecase.fold(
            (l) {
              emit(state.copyWith(
                failure: l,
                status: .failure,
              ));
            },
            (r) {
              emit(state.copyWith(
                user: r,
                status: .success,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: .loading));
          await logoutUseCase(const NoParams());
          emit(state.copyWith(status: .unAuthorized));
          emit(.initial());
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
    );
  }

  final GetProfileUseCase getProfileUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
}
