import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../app/values/app_colors.dart';

class BorderedTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final double borderRadius;
  final double borderSize;
  final double fontSize;
  final bool isTranslatable;
  final EdgeInsets padding;
  final FontWeight? fontWeight;
  final TextAlign textAlign;

  const BorderedTextWidget(
    this.text, {
    Key? key,
    this.fontWeight,
    this.fontSize = 11,
    this.borderSize = 0.8,
    this.borderRadius = 10,
    this.color = colorPrimary,
    this.isTranslatable = false,
    this.textAlign = TextAlign.center,
    this.backgroundColor = colorWhite,
    this.padding = const EdgeInsets.fromLTRB(6, 3, 6, 2),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: isTranslatable
          ? Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
              ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: borderSize > 0
            ? Border.all(
                color: color, // set border color
                width: borderSize,
              )
            : null, // set border width
        borderRadius: BorderRadius.all(
          Radius.circular(
            borderRadius,
          ),
        ),
      ),
    );
  }
}
