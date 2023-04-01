import 'dart:ui';

import 'package:chat_app/resources/colors.dart';
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

  // form login
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
                        # TextFiledUserName(hintText:"fdfsd",onChanged:(newString)=>{
                        #   print(newString)
                        # }),
                        const SizedBox(
                          height: 10,
                        ),
                        # TextFiledPassword(
                        #   hintText: 'Password',
                        #   controller: controllerPasswordLogin,
                        # ),
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
                        buttonCustom('Login', () async {},
                            style: ButtonStyleCustom.white),
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
                              onTap: () {
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
                        # TextFiledUserName(
                        #   hintText: "User name",
                        #   controller: controllerUserNameRegister,
                        # ),
                        const SizedBox(
                          height: 10,
                        ),
                        # TextFiledPassword(
                        #   hintText: 'Password',
                        #   controller: controllerPasswordRegister,
                        # ),
                        const SizedBox(
                          height: 10,
                        ),
                        # TextFiledPassword(
                        #   hintText: 'Confirm password',
                        #   controller: controllerConfirmPasswordRegister,
                        # ),
                        const SizedBox(
                          height: 20,
                        ),
                        buttonCustom('Register', () async {},
                            style: ButtonStyleCustom.white),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
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
