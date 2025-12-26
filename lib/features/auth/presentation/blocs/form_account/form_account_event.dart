part of 'form_account_bloc.dart';

abstract class FormAccountEvent extends Equatable {
  const FormAccountEvent();

  @override
  List<Object> get props => [];
}

class InitialFormAccountEvent extends FormAccountEvent {}

class ChangeNameFormAccountEvent extends FormAccountEvent {
  final String name;

  const ChangeNameFormAccountEvent(this.name);

  @override
  List<Object> get props => [name];
}

class ChangeUsernameFormAccountEvent extends FormAccountEvent {
  final String username;

  const ChangeUsernameFormAccountEvent(this.username);

  @override
  List<Object> get props => [username];
}

class ChangePhoneFormAccountEvent extends FormAccountEvent {
  final String phone;

  const ChangePhoneFormAccountEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class ChangeImageFormAccountEvent extends FormAccountEvent {
  final bool isGallery;

  const ChangeImageFormAccountEvent({this.isGallery = false});

  @override
  List<Object> get props => [isGallery];
}
