import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/values/app_fonts.dart';
import '../../app/values/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color color;
  final double opacity;
  final String? font;
  final int? maxLines;
  final bool isHideKeyboard;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final TextOverflow? textOverflow;
  final VoidCallback? onPressed;
  final TextDecoration? textDecoration;

  const TextWidget(
    this.text, {
    Key? key,
    this.onPressed,
    this.maxLines,
    this.opacity = 1,
    this.textOverflow,
    this.font = defaultFont,
    this.isHideKeyboard = true,
    this.color = colorText,
    this.fontSize = textFontSize,
    this.textAlign = TextAlign.center,
    this.fontWeight = regularFontWeight,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 8),
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? GestureDetector(
            onTapUp: (details) {
              if (isHideKeyboard) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: _getTextWidget(),
            onTap: onPressed,
          )
        : _getTextWidget();
  }

  Widget _getTextWidget() {
    return Padding(
      padding: padding,
      child: Text(
        text ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        style: GoogleFonts.getFont(
          font ?? defaultFont,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color.withOpacity(
            opacity,
          ),
          decoration: textDecoration,
        ),
      ),
    );
  }
}
