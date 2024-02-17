// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tempauth/view/screens/auth/login_page.dart';
import 'package:tempauth/view/widgets/text_widgets.dart';

import '../../utils/constants.dart';
import '../../viewModel/cart_view_model.dart';

Widget clearSavePopUp(BuildContext context) {
  return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
            width: 300.w,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 14, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/alert-circle.svg",
                      width: 53,
                      height: 53,
                    ),
                  ),
                  const Gap(10),
                  Center(
                    child: textInter(
                        text: 'Are you sure you want to log out?',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const Gap(25),
                  // Confirm button
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Provider.of<CartViewModel>(context, listen: false)
                          .cartProduct
                          .clear();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: kprimaryColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: kprimaryColor),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          child: textRedHat(
                              text: "Confirm",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: kwhiteColor),
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  // Cancel button
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: kgreen200),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          child: textRedHat(
                              text: "Cancel",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: kprimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ));
}
