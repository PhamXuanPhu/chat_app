// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SelectItem extends Equatable {
  String id;
  String name;
  SelectItem({
    this.id = '',
    this.name = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SelectItem.fromMap(Map<String, dynamic> map) {
    return SelectItem(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  List<Object> get props => [id, name];

  SelectItem copyWith({
    String? id,
    String? name,
  }) {
    return SelectItem(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
