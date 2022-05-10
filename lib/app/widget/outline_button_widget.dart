import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/values/app_fonts.dart';
import '../../app/values/app_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String? text;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final Color borderColor;
  final double borderWidth;
  final String font;
  final FontWeight fontWeight;
  final double borderRadius;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final String? prefixIcon;

  const OutlineButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.fontSize = 18,
    this.borderRadius = 5,
    this.borderWidth = 1,
    this.font = defaultFont,
    this.width = double.infinity,
    this.textColor = colorPrimary,
    this.borderColor = Colors.grey,
    this.fontWeight = mediumFontWeight,
    this.padding = const EdgeInsets.fromLTRB(20, 5, 20, 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: borderColor,
                width: borderWidth,
                style: BorderStyle.solid,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text ?? "",
              style: GoogleFonts.getFont(
                font,
                fontWeight: fontWeight,
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
