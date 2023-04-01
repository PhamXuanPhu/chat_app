import 'dart:math';
import 'dart:ui';

import 'package:chat_app/api/firebase.dart';
import 'package:chat_app/resources/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../resources/assets.dart';
import '../widgets/button_custom.dart';
import '../widgets/text_filed_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isRemember = false;
  bool isLogin = true;
  String email = "";
  String password = "";
  String confrimPassword = "12345";
  String confrimPassword1 = "";
  String confrimPassword2 = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain,
      body: Stack(
        children: [
          background(),
          isLogin ? loginForm(context) : registerForm(context)
        ],
      ),
    );
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
                            onChanged: (newString) =>
                                {print(newString), email = newString}),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                          hintText: 'Password',
                          onChanged: (value) => {confrimPassword = value},
                          text: confrimPassword,
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
                                    value: isRemember,
                                    onChanged: (value) {
                                      setState(() {
                                        isRemember = value;
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
                            print('login');
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
                                await Future.delayed(
                                    const Duration(microseconds: 150));
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
                          onChanged: (newString) => {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                          hintText: 'Password2',
                          onChanged: (value) => {confrimPassword1 = value},
                          text: confrimPassword1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFiledPassword(
                          hintText: 'Confirm password',
                          onChanged: (value) => {confrimPassword2 = value},
                          text: confrimPassword2,
                        ),
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
                            await Future.delayed(
                                const Duration(microseconds: 150));
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
