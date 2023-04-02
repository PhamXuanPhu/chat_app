import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';

class Save {
  static Future<void> userLogged(String email, String password) async {
    await DataHelper().setData(Config.keyUserName, email);
    await DataHelper().setData(Config.keyPassword, password);
  }
}
