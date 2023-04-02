import 'dart:math';
import 'dart:ui';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/configs/config.dart';
import 'package:chat_app/helper/data_helper.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';
import '../services/save_sevices.dart';
import '../widgets/button_custom.dart';
import '../widgets/text_filed_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isInit = true;
  bool isLogin = true;
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

  @override
  void initState() {
    super.initState();
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
                  isLogin ? loginForm(context) : registerForm(context)
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
  Widget loginForm(BuildContext context) => Center(
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Log in',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 30,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFiledUserName(
                          hintText: "User Name",
                          onChanged: (value) {
                            email = value;
                          },
                          text: email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                          hintText: 'Password',
                          onChanged: (value) {
                            password = value;
                          },
                          text: password,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
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
                                const Text(
                                  'Remeber me',
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 14),
                                )
                              ],
                            ),
                            const Text(
                              'Forgot password?',
                              style: TextStyle(color: colorWhite, fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buttonCustom('Login', () async {
                          bool isLogin =
                              await FirebaseAPI.login(email, password);
                          if (isLogin) {
                            DataHelper().setData(Config.keyRemember, remember);
                            if (remember) {
                              Save.userLogged(email, password);
                            } else {
                              Save.userLogged('', '');
                            }
                            // Navigator.of(context).pushReplacement(Home_Screen())
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home_Screen()),
                            );
                          } else {
                            print('login fail');
                          }
                        }, style: ButtonStyleCustom.white),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: colorWhite, fontSize: 14),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: const Text(
                                ' Register',
                                style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ]),
          )));

  // form login
  Widget registerForm(BuildContext context) => Center(
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 30,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFiledUserName(
                          hintText: "User name",
                          onChanged: (value) => {
                            //email = value
                          },
                          text: email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                          hintText: 'Password',
                          onChanged: (value) => {
                            //password = value
                          },
                          text: password,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                            hintText: 'Confirm password',
                            onChanged: (value) => {confrimPassword = value}),
                        const SizedBox(
                          height: 20,
                        ),
                        buttonCustom('Register', () async {},
                            style: ButtonStyleCustom.white),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLogin = true;
                            });
                          },
                          child: const Text(
                            'Have an account',
                            style: TextStyle(color: colorWhite, fontSize: 14),
                          ),
                        ),
                      ]),
                ),
              ),
            ]),
          )));
}
