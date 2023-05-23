// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Address extends Equatable {
  String countryId;
  String countryName;
  String provinceId;
  String provinceName;
  String districtId;
  String districtName;
  String wardtId;
  String wardName;
  // house number / street/ ward
  String street;
  late String address;
  Address({
    this.countryId = '',
    this.countryName = '',
    this.provinceId = '',
    this.provinceName = '',
    this.districtId = '',
    this.districtName = '',
    this.wardtId = '',
    this.wardName = '',
    this.street = '',
    this.address = '',
  });
  // String address;
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryId': countryId,
      'countryName': countryName,
      'provinceId': provinceId,
      'provinceName': provinceName,
      'districtId': districtId,
      'districtName': districtName,
      'wardtId': wardtId,
      'wardName': wardName,
      'ward': street,
      'address': address,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      countryId: map['countryId'] as String,
      countryName: map['countryName'] as String,
      provinceId: map['provinceId'] as String,
      provinceName: map['provinceName'] as String,
      districtId: map['districtId'] as String,
      districtName: map['districtName'] as String,
      wardtId: map['wardtId'] as String,
      wardName: map['wardName'] as String,
      street: map['ward'] as String,
      address: map['address'] as String,
    );
  }

  @override
  List<Object> get props {
    return [
      countryId,
      countryName,
      provinceId,
      provinceName,
      districtId,
      districtName,
      street,
      address,
      wardtId,
      wardName,
    ];
  }
}
