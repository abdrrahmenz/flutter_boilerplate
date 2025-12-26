import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? image;

  const User({
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [name, email, username, phone, image];
}
