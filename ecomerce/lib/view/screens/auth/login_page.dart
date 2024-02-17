// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/view/widgets/text_widgets.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/auth_view_model.dart';
import '../../widgets/loading.dart';
import '../../widgets/padding.dart';
import '../home/home_page.dart';
import 'login_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNodeUser = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool login = true;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context);
    return GestureDetector(
      onTap: () {
        focusNodePassword.unfocus();
        focusNodeUser.unfocus();
      },
      child: Container(
        color: kwhiteColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: kwhiteColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: setPadding(
                      top: 68,
                      bottom: 50,
                      widget: Lottie.asset('assets/splash.json',
                          animate: true, repeat: false),
                    ),
                  ),
                  Center(
                    child: textInter(
                        text: login ? "Log In" : "Sign Up",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: kmainBlack),
                  ),
                  const Gap(38),
                  LoginInputData(
                      controller: emailController,
                      focusNode: focusNodeUser,
                      password: false),
                  const Gap(16),
                  LoginInputData(
                      controller: passwordController,
                      focusNode: focusNodePassword,
                      password: true),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.w),
                    child: SizedBox(
                        height: 34,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textInter(
                                text: auth.errorMessage,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0XFFFF6068)),
                          ],
                        )),
                  ),
                  auth.loadingAuth ? loading() : loginButton(),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textInter(
                          text: login
                              ? "Does't have an account? "
                              : "Already have an account? ",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: kmainBlack),
                      InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () {
                          emailController.clear();
                          passwordController.clear();
                          Provider.of<Authentication>(context, listen: false)
                              .message('');
                          setState(() {
                            login = !login;
                          });
                        },
                        child: textInter(
                            text: login ? "Sign up" : "Log in",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: kprimaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Login or signup button to authenticate
  Widget loginButton() {
    var auth = Provider.of<Authentication>(context, listen: false);
    return setPadding(
      start: 20,
      end: 20,
      widget: InkWell(
        onTap: () async {
          auth.message("");
          if (emailController.text == "") {
            auth.message("Please enter email");
          } else if (!isEmailValid(emailController.text.trim())) {
            auth.message("Please enter a valid email");
          } else if (passwordController.text == "") {
            auth.message("Please enter password");
          } else if (passwordController.text.length < 6) {
            auth.message("Password sould be least 6 character");
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
            if (login) {
              await auth.login(
                  email: emailController.text,
                  password: passwordController.text);
            } else {
              await auth.registerUser(
                  email: emailController.text,
                  password: passwordController.text);
            }

            // Checking login or register is successfull
            if (auth.isRegistered) {
              emailController.clear();
              passwordController.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage()));
            }
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: ShapeDecoration(
            color: kprimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.r),
            ),
          ),
          child: Center(
            child: textInter(
                text: login ? "Log In" : "Sign Up",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
