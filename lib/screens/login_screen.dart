import 'dart:math';
import 'dart:ui';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';
import '../services/loading_service.dart';
import '../services/save_sevice.dart';
import '../services/toast_service.dart';
import '../widgets/button_custom.dart';
import '../widgets/text_filed_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isInit = true;
  String index = "login";
  bool remember = false;
  String email = "";
  String password = "";
  String confrimPassword = "";

  Future<bool> getData() async {
    if (isInit) {
      remember = await DataHelper().getData<bool>(Config.keyRemember);
      email = await DataHelper().getData(Config.keyUserName);
      password = await DataHelper().getData(Config.keyPassword);
      isInit = false;
    }
    return true;
  }

  void setData() {
    DataHelper().setData(Config.keyRemember, remember);
    if (remember) {
      Save.userLogged(email, password);
    } else {
      Save.userLogged('', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: colorMain,
              body: Stack(
                children: [
                  background(),
                  formBody(index == "login"
                      ? loginForm()
                      : index == "register"
                          ? registerForm()
                          : forgotPasswordForm())
                ],
              ),
            );
          } else {
            return Scaffold(backgroundColor: colorMain, body: background());
          }
        });
  }

  //background
  Widget background() => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: const RiveAnimation.asset(
        Rives.background,
        alignment: Alignment.bottomCenter,
      ));

  //form login
  Widget loginForm() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        formTitle('title_dang_nhap'.tr()),
        space(height: 20),
        TextFiledUserName(
          hintText: 'ten_dang_nhap'.tr(),
          onChanged: (value) {
            email = value;
          },
          text: email,
        ),
        space(),
        TextFiledPassword(
          hintText: 'mat_khau'.tr(),
          onChanged: (value) {
            password = value;
          },
          text: password,
        ),
        space(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    side: const BorderSide(color: colorWhite),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: remember,
                    onChanged: (value) {
                      setState(() {
                        remember = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'luu_dang_nhap'.tr(),
                  style: const TextStyle(color: colorWhite, fontSize: 14),
                )
              ],
            ),
            GestureDetector(
              child: text('quen_mat_khau'.tr()),
              onTap: () {
                setState(() {
                  index = 'forgot';
                });
              },
            )
          ],
        ),
        space(height: 20),
        buttonCustom('btn_dang_nhap'.tr(), () async {
          //  Loading.show();
          bool login = await FirebaseAPI.login(email, password);
          if (login) {
            setData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home_Screen()),
            );
          }
          Toast.success('Đăng ký thành công');
          // Loading.hide();
        }),
        space(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text('chua_co_tai_khoan'.tr()),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  index = 'register';
                });
              },
              child: Text(
                'dang_ky'.tr(),
                style: const TextStyle(
                    color: colorWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // buttonCustom('Login1', () async {
        //   Loading.show();
        //   context.setLocale(const Locale('en', 'US'));
        //   Loading.hide();
        // }),
        // buttonCustom2('Login2', () async {
        //   Loading.show();
        //   context.setLocale(const Locale('vi', 'VN'));
        //   Loading.hide();
        // }),
        // ElevatedButton(
        //   child: Text('text'),
        //   onPressed: () {},
        // )
      ]);

  // form register
  Widget registerForm() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        formTitle('title_dang_ky'.tr()),
        space(height: 20),
        TextFiledUserName(
          hintText: 'ten_dang_nhap'.tr(),
          onChanged: (value) {
            email = value;
          },
          text: email,
        ),
        space(),
        TextFiledPassword(
          hintText: 'mat_khau'.tr(),
          onChanged: (value) {
            password = value;
          },
          text: password,
        ),
        space(),
        TextFiledPassword(
            hintText: 'xac_nhan_mat_khau'.tr(),
            onChanged: (value) => {confrimPassword = value}),
        space(height: 20),
        buttonCustom('btn_dang_ky'.tr(), () async {
          bool register = await FirebaseAPI.register(email, password);
          if (register) {
            // ignore: use_build_context_synchronously
            Toast.success('Đăng ký thành công');
            setState(() {
              index = 'login';
            });
          }
        }),
        space(height: 20),
        InkWell(
          onTap: () async {
            setState(() {
              index = 'login';
            });
          },
          child: text('da_co_tai_khoan'.tr()),
        ),
      ]);
//forgot password
  Widget forgotPasswordForm() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          formTitle('Forgot password'),
          space(height: 20),
          TextFiledUserName(
              hintText: 'email',
              onChanged: (value) {
                email = value;
              }),
          space(height: 20),
          buttonCustom('Reset password', () async {
            bool forgotPassword = await FirebaseAPI.forgotPassword(email);
            if (forgotPassword) {
              Toast.success('Reset password in your email.');
            }
          })
        ],
      );

//form
  Widget formBody(Widget child) => Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Wrap(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                  child: child,
                ),
              ),
            ]),
          )));
  //form title
  Text formTitle(String text) => Text(
        text,
        style: const TextStyle(
            color: colorWhite, fontSize: 30, fontFamily: 'Poppins'),
      );
  //space
  SizedBox space({double height = 10}) => SizedBox(
        height: height,
      );
  Text text(String text) => Text(
        text,
        style: const TextStyle(color: colorWhite, fontSize: 14),
      );
}
