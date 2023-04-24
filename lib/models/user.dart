// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final List<dynamic> contact_array;
  final List<dynamic> request_array;
  final List<dynamic> send_array;
  final bool online;

  const User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.avatar = '',
    this.contact_array = const <dynamic>[],
    this.request_array = const <dynamic>[],
    this.send_array = const <dynamic>[],
    this.online = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatar,
        request_array,
        contact_array,
        send_array,
        online
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'contact_array': contact_array,
      'request_array': request_array,
      'send_array': send_array,
      'online': online,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      avatar: map['avatar'] ?? "",
      contact_array: map['contact_array'] ?? const <dynamic>[],
      request_array: map['request_array'] ?? const <dynamic>[],
      send_array: map['send_array'] ?? const <dynamic>[],
      online: map['online'] ?? false,
    );
  }
}
