import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Utils/theme_styles.dart';
import 'custom_text_widget.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    this.borderRadius,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.buttonWidth,
    this.fontSize,
    this.fontWeight,
    required this.buttonText,
    this.buttonHeight,
    this.gradient,
    required this.isLoading,
    this.textDecoration,
    required this.iconColor,
    required this.assetName,
    super.key,

  });
  final VoidCallback onTap;
  final Color? buttonColor;
  final double? borderRadius;
  final Color? textColor;
  final String buttonText;
  final Color? borderColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final bool isLoading;
  final TextDecoration? textDecoration;
 final Color iconColor;
  final String assetName ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 50,
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: gradient,
          color: buttonColor ?? Colors.white,
          border: Border.all(color: borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: !isLoading
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(assetName  , colorFilter:  ColorFilter.mode(iconColor, BlendMode.srcIn),height: 25,),
                      const SizedBox(width: 10,),
                      CustomTextWidget(
                          text: buttonText,
                          color: textColor,
                          fontSize: fontSize ?? 15.0,
                          fontWeight: fontWeight ?? FontWeight.w400,
                          textDecoration: textDecoration ?? TextDecoration.none,
                        ),



                    ],
                  )
                  : const CircularProgressIndicator(
                      color: ThemeStyles.whiteColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
