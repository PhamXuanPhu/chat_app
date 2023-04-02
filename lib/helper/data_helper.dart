import 'package:shared_preferences/shared_preferences.dart';

/// Hàm trả về dữ liệu đã lưu trong SharedPreferences
/// Sử dụng [key] và kiểu dữ liệu [T] tương ứng để lưu hoặc lấy giá trị
/// Ví dụ : int sum = await DataHelper().getData<int>('key')
class DataHelper {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  Future<T> getData<T>(String key) async {
    prefs = await _prefs;
    if (T == String) {
      return (prefs.getString(key) ?? "") as T;
    } else if (T == bool) {
      return (prefs.getBool(key) ?? false) as T;
    } else if (T == int) {
      return (prefs.getInt(key) ?? 0) as T;
    } else {
      throw Exception("Type is not supported.");
    }
  }

  Future<void> setData<T>(String key, T value) async {
    prefs = await _prefs;
    if (T == String) {
      prefs.setString(key, value as String);
    } else if (T == bool) {
      prefs.setBool(key, value as bool);
    } else if (T == int) {
      prefs.setInt(key, value as int);
    } else {
      throw Exception("Type is not supported.");
    }
  }
}
