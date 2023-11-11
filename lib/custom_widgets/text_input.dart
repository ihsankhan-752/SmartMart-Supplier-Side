import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AuthTextInput extends StatelessWidget {
  final String? hintText;
  final bool isSuffixReq;
  final Widget? suffixWidget;
  final TextEditingController? controller;

  const AuthTextInput({Key? key, this.hintText, this.isSuffixReq = false, this.suffixWidget, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 05),
        child: TextField(
          cursorColor: AppColors.primaryWhite,
          style: TextStyle(
            color: AppColors.primaryWhite,
          ),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: isSuffixReq ? suffixWidget : null,
            hintStyle: TextStyle(
              color: AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
