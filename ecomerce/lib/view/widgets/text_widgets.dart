import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textInter(
    {required text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? fontHeight,
    double? letterSpacing}) {
  return Text(
    text,
    style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: fontHeight ?? fontHeight,
        letterSpacing: letterSpacing ?? letterSpacing),
  );
}

Widget textRedHat(
    {required text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign? textAlign,
    double? fontHeight,
    double? letterSpacing}) {
  return Text(
    text,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign ?? textAlign,
    style: GoogleFonts.redHatDisplay(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: fontHeight ?? fontHeight,
        letterSpacing: letterSpacing ?? letterSpacing),
  );
}
