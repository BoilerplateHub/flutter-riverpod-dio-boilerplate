import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../exports/app_values_export.dart';
import '../exports/generated_values_export.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hint;
  final String font;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final bool autofocus;
  final bool isValidate;
  final double? fontSize;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final Color textFontColor;
  final VoidCallback? onTap;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool disableLabelText;
  final String? defaultValue;
  final FontWeight fontWeight;
  final Color? prefixIconColor;
  final bool isEmailValidation;
  final bool isRemoveBottomBorder;
  final EdgeInsets contentPadding;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final InputBorder? inputDecorationBorder;
  final Function(String? value) onChanged;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FilteringTextInputFormatter? inputFormatters;

  const TextFormFieldWidget({
    Key? key,
    this.hint,
    this.onTap,
    this.suffixIcon,
    this.suffixWidget,
    this.prefixIcon,
    this.maxLines = 1,
    this.defaultValue,
    this.enabled = true,
    this.inputFormatters,
    this.font = defaultFont,
    this.readOnly = false,
    this.isValidate = true,
    this.autofocus = false,
    required this.onChanged,
    this.inputDecorationBorder,
    this.floatingLabelBehavior,
    this.fontSize = textFontSize,
    this.disableLabelText = false,
    this.isEmailValidation = false,
    this.textAlign = TextAlign.start,
    this.isRemoveBottomBorder = false,
    this.fontWeight = regularFontWeight,
    this.textFontColor = colorText,
    this.prefixIconColor = colorText,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 8),
    this.contentPadding = const EdgeInsets.fromLTRB(0, 0, 0, 8),
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Form(
        key: _formKey,
        child: TextFormField(
          onTap: widget.onTap,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          textAlign: widget.textAlign,
          autofocus: widget.autofocus,
          initialValue: widget.defaultValue,
          onChanged: (value) {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate() &&
                value.isNotEmpty) {
              widget.onChanged(value);
            } else {
              widget.onChanged(null);
            }
          },
          validator: widget.isValidate
              ? (value) {
                  var hintText = widget.hint ?? "";

                  if (value == null || value.trim().isEmpty) {
                    return hintText + LocaleKeys.empty_field_warning.tr();
                  } else if (widget.isEmailValidation) {
                    if (value.contains(" ")) {
                      return hintText +
                          LocaleKeys.can_not_contain_white_space.tr();
                    } else if (!RegExp(emailPattern).hasMatch(value)) {
                      return "Invalid $hintText Address";
                    }
                  }

                  return null;
                }
              : null,
          inputFormatters:
              widget.inputFormatters == null ? null : [widget.inputFormatters!],
          style: GoogleFonts.getFont(
            widget.font,
            fontWeight: widget.fontWeight,
            color: widget.textFontColor,
            fontSize: widget.fontSize,
          ),
          enableSuggestions: true,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorMaxLines: 2,
            filled: widget.isRemoveBottomBorder,
            fillColor: widget.isRemoveBottomBorder ? Colors.transparent : null,
            border: widget.inputDecorationBorder,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            suffix: widget.suffixWidget,
            hintText: widget.hint ?? "",
            labelText: widget.disableLabelText ? null : widget.hint ?? "",
            contentPadding: widget.contentPadding,
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
                    icon: Icon(
                      widget.suffixIcon,
                      color: widget.prefixIconColor,
                    ),
                    onPressed: () {},
                  )
                : null,
            prefixIcon: widget.prefixIcon != null
                ? IconButton(
                    icon: Icon(
                      widget.prefixIcon,
                      color: widget.prefixIconColor,
                    ),
                    onPressed: () {},
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
