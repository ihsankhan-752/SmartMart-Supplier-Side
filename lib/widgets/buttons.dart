import 'package:flutter/material.dart';

import '../constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? btnColor;
  final double? width;
  const PrimaryButton({Key? key, this.title, this.onPressed, this.btnColor, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: 55,
      onPressed: onPressed,
      child: Text(
        title!,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Mirador',
          color: AppColors.primaryWhite,
        ),
      ),
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Function()? onPressed;
  const MainButton({Key? key, this.width, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ),
    );
  }
}
