import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LogoWidget extends StatelessWidget {
  final double? fontSize;
  const LogoWidget({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SmartMart\nSupplier Center",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize ?? 40,
          fontFamily: 'Mirador',
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
