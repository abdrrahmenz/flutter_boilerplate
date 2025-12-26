import 'package:equatable/equatable.dart';
import '../../auth.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? image;
  final String role;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.image,
    required this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  User toEntity() {
    return User(
      name: name,
      email: email,
      username: username,
      image: image,
      phone: phone,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        phone: json['phone'] as String?,
        image: json['image'] as String?,
        role: json['role'] as String,
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.parse(json['email_verified_at'] as String)
            : null,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        phone,
        image,
        role,
        emailVerifiedAt,
        createdAt,
        updatedAt,
      ];
}
