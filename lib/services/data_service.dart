import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';

class DataService {
  static Future<void> userLogged(String email, String password) async {
    await DataHelper().setData(Config.keyEmail, email);
    await DataHelper().setData(Config.keyPassword, password);
  }

  static Future<String> getEmail() async {
    return await DataHelper().getData(Config.keyEmail);
  }

  static Future<String> getPassword() async {
    return await DataHelper().getData(Config.keyPassword);
  }
}
