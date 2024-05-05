import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextInput extends StatelessWidget {
  final String? hintText;
  final Widget? suffixWidget;
  final bool? isSecureText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final int? maxLines;

  const CustomTextInput({
    Key? key,
    this.hintText,
    this.suffixWidget,
    this.controller,
    this.isSecureText,
    this.inputType,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      obscureText: isSecureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      cursorColor: AppColors.primaryBlack,
      style: TextStyle(
        color: AppColors.primaryBlack,
      ),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xfff4f9f9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: EdgeInsets.only(left: 10),
        border: InputBorder.none,
        hintText: hintText,
        suffixIcon: suffixWidget ?? SizedBox(),
        hintStyle: TextStyle(
          color: AppColors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
