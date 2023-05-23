// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String id;
  String name;
  String email;
  String avatar;
  List<dynamic> contact_array;
  List<dynamic> request_array;
  List<dynamic> send_array;
  bool online;
  bool mode;
  String language;
  bool active_status;

  User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.avatar = '',
    this.contact_array = const <dynamic>[],
    this.request_array = const <dynamic>[],
    this.send_array = const <dynamic>[],
    this.online = false,
    this.mode = false,
    this.language = '',
    this.active_status = false,
  });

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
      'mode': mode,
      'language': language,
      'active_status': active_status,
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
      mode: map['mode'] ?? false,
      language: map['language'] ?? "",
      active_status: map['active_status'] ?? true,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatar,
        contact_array,
        request_array,
        send_array,
        online,
        mode,
        language,
        active_status,
      ];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    List<dynamic>? contact_array,
    List<dynamic>? request_array,
    List<dynamic>? send_array,
    bool? online,
    bool? mode,
    String? language,
    bool? active_status,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      contact_array: contact_array ?? this.contact_array,
      request_array: request_array ?? this.request_array,
      send_array: send_array ?? this.send_array,
      online: online ?? this.online,
      mode: mode ?? this.mode,
      language: language ?? this.language,
      active_status: active_status ?? this.active_status,
    );
  }
}
