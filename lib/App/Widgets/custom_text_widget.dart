import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/theme_styles.dart';


class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  const CustomTextWidget({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.textAlign,
    this.textDecoration,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // textAlign: TextAlign.left,
      softWrap: true,
      overflow: overflow,
      textAlign: textAlign ??
          TextAlign
              .start, // I used ellipsis, but it works with others (fade, clip, etc.)

      maxLines: maxLines ?? 3,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 14,
        color: color ?? ThemeStyles.whiteColor,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        decoration: textDecoration,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }
}
