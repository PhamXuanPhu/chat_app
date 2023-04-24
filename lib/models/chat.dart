// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final String last_message;
  final Timestamp? update_on;
  final List<dynamic> members;
  final Map<String, dynamic>? online;

  const Chat(
      {this.id = '',
      this.last_message = '',
      this.update_on,
      this.members = const <dynamic>[],
      this.online});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'last_message': last_message,
      'update_on': update_on,
      'members': members,
      'online': online,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? "",
      last_message: map['last_message'] ?? "",
      update_on: map['update_on'] ?? null,
      members: map['members'] ?? const <dynamic>[],
      online: map['online'] ?? null,
    );
  }

  @override
  List<Object?> get props => [id, last_message, update_on, members, online];
}
