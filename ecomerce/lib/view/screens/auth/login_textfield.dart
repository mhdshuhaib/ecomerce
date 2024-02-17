import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../viewModel/auth_view_model.dart';
import '../../widgets/padding.dart';

// ignore: must_be_immutable
class LoginInputData extends StatefulWidget {
  final bool password;
  final TextEditingController controller;
  final FocusNode focusNode;
  const LoginInputData(
      {super.key,
      required this.controller,
      required this.password,
      required this.focusNode});

  @override
  State<LoginInputData> createState() => _LoginInputDataState();
}

class _LoginInputDataState extends State<LoginInputData> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return setPadding(
      start: 20.w,
      end: 20.w,
      widget: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: !isPasswordVisible && widget.password,
        cursorColor: kdarkGrey,
        onChanged: (value) {
          Provider.of<Authentication>(context, listen: false).message('');
        },
        decoration: InputDecoration(
          prefixIcon: widget.password
              ? Icon(
                  Icons.lock_outline,
                  color: kdarkGrey,
                  size: 20.sp,
                )
              : Icon(
                  Icons.email_outlined,
                  color: kdarkGrey,
                  size: 20.sp,
                ),
          suffixIcon: widget.password
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    isPasswordVisible = !isPasswordVisible;
                    setState(() {});
                  },
                  child: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: kdarkGrey,
                    size: 20.sp,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: kgreen200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: kgray2),
          ),
          hintText: widget.password ? "Password" : "Email",
          hintStyle: GoogleFonts.redHatDisplay(
              fontSize: 14.sp, fontWeight: FontWeight.w400, color: kdarkGrey),
        ),
      ),
    );
  }
}
