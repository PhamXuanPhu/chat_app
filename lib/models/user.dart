// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] ?? "", // as String,
        name: map['name'] ?? "", //as String,
        email: map['email'] ?? "" // ,as String,
        );
  }

  @override
  List<Object?> get props => [id, name, email];
}
