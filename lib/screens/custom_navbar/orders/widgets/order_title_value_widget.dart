import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class OrderTitleValueWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String? value;
  final Color? valueColor;
  const OrderTitleValueWidget({super.key, this.title, this.icon, this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.primaryBlack),
        SizedBox(width: 10),
        Text(
          title!,
          style: TextStyle(fontSize: 13, letterSpacing: 0.5, fontWeight: FontWeight.bold),
        ),
        Text(
          value!,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.primaryBlack,
          ),
        ),
      ],
    );
  }
}
