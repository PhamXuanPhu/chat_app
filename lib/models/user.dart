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
  String country_id;
  String country_name;
  String province_id;
  String province_name;
  String district_id;
  String district_name;
  String ward_id;
  String ward_name;
  String street;
  String address;
  String gender;
  String birthday;
  String phone;
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
    this.country_id = '',
    this.country_name = '',
    this.province_id = '',
    this.province_name = '',
    this.district_id = '',
    this.district_name = '',
    this.ward_id = '',
    this.ward_name = '',
    this.street = '',
    this.address = '',
    this.gender = '',
    this.birthday = '',
    this.phone = '',
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
      'country_id': country_id,
      'country_name': country_name,
      'province_id': province_id,
      'province_name': province_name,
      'district_id': district_id,
      'district_name': district_name,
      'ward_id': ward_id,
      'ward_name': ward_name,
      'ward': street,
      'address': address,
      'gender': gender,
      'birthday': birthday,
      'phone': phone,
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
      country_id: map['country_id'] ?? "",
      country_name: map['country_name'] ?? "",
      province_id: map['province_id'] ?? "",
      province_name: map['province_name'] ?? "",
      district_id: map['district_id'] ?? "",
      district_name: map['district_name'] ?? "",
      ward_id: map['ward_id'] ?? "",
      ward_name: map['ward_name'] ?? "",
      street: map['street'] ?? "",
      address: map['address'] ?? "",
      gender: map['gender'] ?? "",
      birthday: map['birthday'] ?? "",
      phone: map['phone'] ?? "",
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
        country_id,
        country_name,
        province_id,
        province_name,
        district_id,
        district_name,
        street,
        address,
        ward_id,
        ward_name,
        gender,
        birthday,
        phone
      ];

  User copyWith(
      {String? id,
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
      String? country_id,
      String? country_name,
      String? province_id,
      String? province_name,
      String? district_id,
      String? district_name,
      String? ward_id,
      String? ward_name,
      String? street,
      String? address,
      String? gender,
      String? birthday,
      String? phone}) {
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
      country_id: country_id ?? this.country_id,
      country_name: country_name ?? this.country_name,
      province_id: province_id ?? this.province_id,
      province_name: province_name ?? this.province_name,
      district_id: district_id ?? this.district_id,
      district_name: district_name ?? this.district_name,
      ward_id: ward_id ?? this.ward_id,
      ward_name: ward_name ?? this.ward_name,
      street: street ?? this.street,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
    );
  }
}
