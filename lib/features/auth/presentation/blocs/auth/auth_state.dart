part of 'auth_bloc.dart';

enum AuthStateStatus {
  initial,
  loading,
  authorized,
  unAuthorized,
  success,
  failure
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.initial,
    this.failure,
    this.user,
  });

  factory AuthState.initial() {
    return const AuthState();
  }

  final AuthStateStatus status;
  final Failure? failure;
  final User? user;

  AuthState copyWith({
    AuthStateStatus? status,
    Failure? failure,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, failure, user];
}
