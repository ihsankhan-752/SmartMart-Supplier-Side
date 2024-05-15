import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? btnColor;
  final double? width, height;
  const PrimaryButton({Key? key, this.title, this.onPressed, this.btnColor, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: height ?? 55,
      onPressed: onPressed,
      child: Center(
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Mirador',
            color: AppColors.primaryWhite,
          ),
        ),
      ),
      color: btnColor ?? AppColors.primaryColor,
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

class SmallButton extends StatelessWidget {
  final double? width, height;
  final Color? btnColor;
  final String? title;
  final Color? textColor;
  final Function()? onPressed;
  const SmallButton({super.key, this.width, this.btnColor, this.title, this.textColor, this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: height ?? 40,
        width: width,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title!,
            style: AppTextStyles().H2.copyWith(
                  fontSize: 12,
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}
