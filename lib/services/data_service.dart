import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';
import 'package:chat_app/models/user.dart';

class DataService {
  static Future<void> userLogged(String email, String password) async {
    await DataHelper().setData(Config.keyUserName, email);
    await DataHelper().setData(Config.keyPassword, password);
  }

  static Future<void> setMode(bool mode) async {
    await DataHelper().setData(Config.keyMode, mode);
  }

  static Future<bool> getMode() async {
    return await DataHelper().getData(Config.keyMode);
  }

  static Future<void> setLanguage(String language) async {
    await DataHelper().setData(Config.keyLanguage, language);
  }

  static Future<String> getLanguage() async {
    return await DataHelper().getData(Config.keyLanguage);
  }
}
