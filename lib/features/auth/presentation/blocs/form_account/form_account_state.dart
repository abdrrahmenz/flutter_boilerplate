part of 'form_account_bloc.dart';

class FormAccountState extends Equatable {
  const FormAccountState({
    this.name = const NameFormZ.dirty(),
    this.username = const NameFormZ.dirty(),
    this.phone = const PhoneFormZ.dirty(),
    this.image,
  });

  factory FormAccountState.initial() {
    return const FormAccountState();
  }

  final NameFormZ name;
  final NameFormZ username;
  final PhoneFormZ phone;
  final File? image;

  bool get isValid => name.isValid && username.isValid && phone.isValid;

  FormAccountState copyWith({
    NameFormZ? name,
    NameFormZ? username,
    PhoneFormZ? phone,
    File? image,
  }) {
    return FormAccountState(
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [name, username, phone, image];
}
