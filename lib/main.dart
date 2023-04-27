import 'dart:async';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/blocs/setting/setting_bloc.dart';
import 'package:chat_app/blocs/user/user_bloc.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/services/app_router.dart';
import 'package:chat_app/services/data_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'resources/theme.dart';
import 'services/global_key.dart';
import 'widgets/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var locale = await getLocale();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'lib/resources/translations',
        fallbackLocale: locale,
        child: const MainApp()),
  );
}

Future<Locale> getLocale() async {
  var language = await DataService.getLanguage();
  return language == Config.enCode ? Config.english : Config.vietnamese;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  bool mode = false;
  bool notification = false;
  bool state = false;

  Future<void> init() async {
    mode = await DataService.getMode();
    state = await DataService.getState();
    await Firebase.initializeApp();
    FirebaseAPI.init();
  }

  Future<bool> checkLogin() async {
    await init();
    return await FirebaseAPI.checkLogin();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
                    return SettingBloc()
                      ..add(SwitchThemeApp(switchValue: mode));
                  }),
                ],
                child: BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    return MaterialApp(
                        theme: state.theme
                            ? MyTheme.darkTheme
                            : MyTheme.lightTheme,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        navigatorKey: GlobalVariable.navigatorKey,
                        onGenerateRoute: AppRouter().onGenerateRoute,
                        home: snapshot.data!
                            ? const HomeScreen()
                            : const LoginScreen());
                  },
                ));
          } else {
            return loadingScreen();
          }
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (state) {
      if (appLifecycleState == AppLifecycleState.resumed) {
        FirebaseAPI.updateStateUser(true);
      } else {
        FirebaseAPI.updateStateUser(false);
      }
    }
  }
}
