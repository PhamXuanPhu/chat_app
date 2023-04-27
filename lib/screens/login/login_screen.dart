import 'dart:ui';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/widgets/sizedbox_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../resources/assets.dart';
import '../../services/loading_service.dart';
import '../../services/data_service.dart';
import '../../services/toast_service.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/text_filed_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isInit = true;
  int _currentIndex = 0;
  String email = "";
  String password = "";
  String name = "";

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegister = GlobalKey<FormState>();
  final _formKeyForgotPassword = GlobalKey<FormState>();

  Future<bool> getData() async {
    if (isInit) {
      email = await DataHelper().getData(Config.keyUserName);
      password = await DataHelper().getData(Config.keyPassword);
      isInit = false;
    }
    return true;
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
                  IndexedStack(
                    index: _currentIndex,
                    children: [
                      formBody(loginForm(), 0),
                      formBody(registerForm(), 1),
                      formBody(forgotPasswordForm(), 2),
                    ],
                  )
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
  Widget loginForm() => Form(
        key: _formKeyLogin,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          formTitle('title_dang_nhap'.tr()),
          height10(value: 20),
          TextFiledEmail(
            hintText: 'email'.tr(),
            onChanged: (value) {
              email = value;
            },
            text: email,
          ),
          height10(),
          TextFiledPassword(
            hintText: 'mat_khau'.tr(),
            onChanged: (value) {
              password = value;
            },
            text: password,
          ),
          height10(value: 20),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: text('quen_mat_khau'.tr()),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ),
          height10(value: 15),
          buttonCustom(
            'btn_dang_nhap'.tr(),
            () async {
              if (_formKeyLogin.currentState!.validate()) {
                _formKeyLogin.currentState!.save();

                Loading.show(context);
                String result = await FirebaseAPI.login(email, password);
                if (result.isEmpty) {
                  Toast.success('noti_dang_nhap_thanh_cong'.tr());
                  DataService.userLogged(email, password);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  Toast.message(result);
                }
                Loading.hide();
              }
            },
          ),
          buttonCustom('btn_dang_nhap'.tr(), () async {
            if (_formKeyLogin.currentState!.validate()) {
              _formKeyLogin.currentState!.save();
              //   Loadingg.show(context);
              await Future.delayed(const Duration(milliseconds: 5000));
//Loadingg.hide();
            }
          }),
          height10(value: 20),
          FittedBox(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'chua_co_tai_khoan'.tr(),
                children: <TextSpan>[
                  const TextSpan(text: ' '),
                  TextSpan(
                      text: 'dang_ky'.tr(),
                      style: const TextStyle(
                          color: colorWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        }),
                ],
              ),
            ),
          ),
        ]),
      );

  // form register
  Widget registerForm() => Form(
        key: _formKeyRegister,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          formTitle('title_dang_ky'.tr()),
          height10(value: 20),
          TextFiledUserName(
            hintText: 'ten_nguoi_dung'.tr(),
            onChanged: (value) => {name = value},
            text: name,
          ),
          height10(),
          TextFiledEmail(
            hintText: 'email'.tr(),
            onChanged: (value) {
              email = value;
            },
            text: email,
          ),
          height10(),
          TextFiledPassword(
            hintText: 'mat_khau'.tr(),
            onChanged: (value) {
              password = value;
            },
            text: password,
          ),
          height10(value: 20),
          buttonCustom('btn_dang_ky'.tr(), () async {
            if (_formKeyRegister.currentState!.validate()) {
              _formKeyRegister.currentState!.save();

              Loading.show(context);
              String register =
                  await FirebaseAPI.register(name, email, password);
              if (register.isEmpty) {
                // ignore: use_build_context_synchronously
                Toast.successAction(
                    context: context,
                    message: 'noti_dang_ky_thanh_cong'.tr(),
                    acction: 'Login',
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    });
              } else {
                Toast.error(register);
              }
              Loading.hide();
            }
          }),
          height10(value: 20),
          InkWell(
            onTap: () async {
              setState(() {
                _currentIndex = 0;
              });
            },
            child: text('da_co_tai_khoan'.tr()),
          ),
        ]),
      );

  Future<bool> run() async {
    await Future.delayed(Duration(seconds: 5));
    return true;
  }

//forgot password
  Widget forgotPasswordForm() => Form(
        key: _formKeyForgotPassword,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formTitle('Forgot password'),
            height10(value: 20),
            TextFiledEmail(
                hintText: 'email',
                onChanged: (value) {
                  email = value;
                }),
            height10(value: 20),
            buttonCustom('Reset password', () async {
              if (_formKeyForgotPassword.currentState!.validate()) {
                _formKeyForgotPassword.currentState!.save();

                Loading.show(context);
                bool forgotPassword = await FirebaseAPI.forgotPassword(email);
                if (forgotPassword) {
                  Toast.success('noti_dat_lai_mat_khau_trong_email'.tr());
                  setState(() {
                    _currentIndex = 0;
                  });
                } else {
                  Toast.success('noti_loi_he_thong'.tr());
                }
                Loading.hide();
              }
            }),
            height10(value: 20),
            InkWell(
              onTap: () async {
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: text('quay_lai_trang_dang_nhap'.tr()),
            ),
          ],
        ),
      );

//form
  Widget formBody(Widget child, int index) => Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Wrap(children: [
              AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                width: _currentIndex == index
                    ? MediaQuery.of(context).size.width * 0.8
                    : 0,
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
  Widget formTitle(String text) => FittedBox(
        child: Text(
          text,
          style: const TextStyle(
              color: colorWhite, fontSize: 30, fontFamily: 'Poppins'),
          overflow: TextOverflow.ellipsis,
        ),
      );
  Widget text(String text) => FittedBox(
        child: Text(
          text,
          style: const TextStyle(color: colorWhite, fontSize: 14),
        ),
      );
}