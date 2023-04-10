import 'dart:async';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/blocs/switch/switch_bloc.dart';
import 'package:chat_app/blocs/user/user_bloc.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/services/data_sevice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resources/theme.dart';
import 'services/global_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var locale = await getLocale();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'lib/resources/translations',
        fallbackLocale: locale,
        child: MainApp()),
  );
}

Future<Locale> getLocale() async {
  var language = await DataService.getLanguage();
  return language == Config.enCode ? Config.english : Config.vietnamese;
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  bool mode = false;

  Future<void> init() async {
    //FirebaseApp firebaseApp =
    mode = await DataService.getMode();
    await Firebase.initializeApp();
    FirebaseAPI.init();
  }

  Future<bool> checkLogin() async {
    await init();
    return await FirebaseAPI.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => UserBloc()),
                  BlocProvider(create: (context) {
                    return SwitchBloc()..add(SwitchEvent(switchValue: mode));
                  }),
                ],
                child: BlocBuilder<SwitchBloc, SwitchState>(
                  builder: (context, state) {
                    return MaterialApp(
                        theme: state.switchValue
                            ? MyTheme.darkTheme
                            : MyTheme.lightTheme,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        navigatorKey: GlobalVariable.navigatorKey,
                        home: snapshot.data!
                            ? const HomeScreen()
                            : const LoginScreen());
                  },
                ));
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }
}
