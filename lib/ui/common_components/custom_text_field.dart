import 'package:flutter/material.dart';
import 'package:task_demo/constant/import.dart';
import 'package:task_demo/cubit/theme_module/states/change_theme_states.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final ChangeThemeState themeState;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final Function? onChange;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.themeState,
    this.onChange,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.hintStyle,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.border,
    this.fillColor,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey[300]!;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      style: textStyle,
      onChanged: (value) {
        var callBack = onChange;
        if (callBack != null) {
          callBack(value);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeState.customColors[AppColors.darkGrey] ?? borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeState.customColors[AppColors.darkGrey] ?? borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeState.customColors[AppColors.darkGrey] ?? borderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeState.customColors[AppColors.darkGrey] ?? borderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeState.customColors[AppColors.darkGrey] ?? borderColor,
          ),
        ),
      ),
    );
  }
}
