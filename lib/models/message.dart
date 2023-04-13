// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String chat_id;
  final String from_id;
  final String message;
  final Timestamp update_on;
  final String to_id;
  final bool show;
  const Message(
      {required this.id,
      required this.chat_id,
      required this.from_id,
      required this.message,
      required this.update_on,
      required this.to_id,
      required this.show});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chat_id': chat_id,
      'from_id': from_id,
      'message': message,
      'update_on': update_on,
      'to_id': to_id,
      'show': show,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? "",
      chat_id: map['chat_id'] ?? "",
      from_id: map['from_id'] ?? "",
      message: map['message'] ?? "",
      update_on: map['update_on'] ?? Timestamp.now(),
      to_id: map['to_id'] ?? "",
      show: map['show'] ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [id, chat_id, from_id, message, update_on, to_id, show];
}
