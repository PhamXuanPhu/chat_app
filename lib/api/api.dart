import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/select_item.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class API {
  final dio = Dio();

  Future<List<SelectItem>> getProvinces() async {
    try {
      List<SelectItem> provinces = [];
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final response = await dio
          .get('https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1');
      if (response.statusCode == HttpStatus.ok) {
        var result = response.data['data']['data'];
        if (result != null) {
          for (var item in result) {
            provinces.add(
                SelectItem(id: item['code'].toString(), name: item['name']));
          }
        }
      } else {
        throw Exception('Failed to get data.');
      }
      return provinces;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<SelectItem>> getDistricts(String provinceId) async {
    try {
      List<SelectItem> districts = [];
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final response = await dio.get(
          'https://vn-public-apis.fpo.vn/districts/getByProvince?provinceCode=$provinceId&limit=-1');
      if (response.statusCode == HttpStatus.ok) {
        var result = response.data['data']['data'];
        if (result != null) {
          for (var item in result) {
            districts.add(
                SelectItem(id: item['code'].toString(), name: item['name']));
          }
        }
      } else {
        throw Exception('Failed to get data.');
      }
      return districts;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<SelectItem>> getWards(String districtId) async {
    try {
      List<SelectItem> wards = [];
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final response = await dio.get(
          'https://vn-public-apis.fpo.vn/wards/getByDistrict?districtCode=$districtId&limit=-1');
      if (response.statusCode == HttpStatus.ok) {
        var result = response.data['data']['data'];
        if (result != null) {
          for (var item in result) {
            wards.add(
                SelectItem(id: item['code'].toString(), name: item['name']));
          }
        }
      } else {
        throw Exception('Failed to get data.');
      }
      return wards;
    } catch (e) {
      throw Exception(e);
    }
  }
}
