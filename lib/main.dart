import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/data_helper.dart';
import 'services/global_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('vi', 'VN'),
        child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<FirebaseApp> initFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

// kiểm tra user đã login chưa, nếu user đã login thành công và có check remember mới lưu đăng nhập
  Future<bool> checkLogin() async {
    await initFirebase();
    bool remember = await DataHelper().getData(Config.keyRemember);
    if (remember) {
      String email = await DataHelper().getData(Config.keyUserName);
      String password = await DataHelper().getData(Config.keyPassword);
      if (email.isNotEmpty && password.isNotEmpty) {
        bool isLogin = await FirebaseAPI.login(email, password);
        return isLogin;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: GlobalVariable.navigatorKey,
        home: FutureBuilder(
            future: checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!
                    ? const Home_Screen()
                    : const LoginScreen();
              } else {
                return const CupertinoActivityIndicator();
              }
            }));
  }
}
