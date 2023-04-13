// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final String from_id;
  final String from_name;
  final String from_avata;
  final String to_id;
  final String to_name;
  final String to_avatar;
  final String last_message;
  final Timestamp? update_on;
  final List<dynamic> members;

  const Chat(
      this.id,
      this.from_id,
      this.from_name,
      this.from_avata,
      this.to_id,
      this.to_name,
      this.to_avatar,
      this.last_message,
      this.update_on,
      this.members);

  Chat copyWith({
    String? id,
    String? from_id,
    String? from_name,
    String? from_avata,
    String? to_id,
    String? to_name,
    String? to_avata,
    String? last_message,
    Timestamp? update_on,
    List<dynamic>? members,
  }) {
    return Chat(
      id ?? this.id,
      from_id ?? this.from_id,
      from_name ?? this.from_name,
      from_avata ?? this.from_avata,
      to_id ?? this.to_id,
      to_name ?? this.to_name,
      to_avata ?? this.to_avatar,
      last_message ?? this.last_message,
      update_on ?? this.update_on,
      members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from_id': from_id,
      'from_name': from_name,
      'from_avata': from_avata,
      'to_id': to_id,
      'to_name': to_name,
      'to_avata': to_avatar,
      'last_message': last_message,
      'update_on': update_on,
      'members': members,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      map['id'] ?? "",
      map['from_id'] ?? "",
      map['from_name'] ?? "",
      map['from_avata'] ?? "",
      map['to_id'] ?? "",
      map['to_name'] ?? "",
      map['to_avata'] ?? "",
      map['last_message'] ?? "",
      map['update_on'] ?? null,
      map['members'] ?? [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        from_id,
        from_name,
        from_avata,
        to_id,
        to_name,
        to_avatar,
        last_message,
        update_on,
        members
      ];
}
