import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';

class TitleValueWidget extends StatelessWidget {
  final String? title, value;
  const TitleValueWidget({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            fontSize: 14,
            color: AppColors.grey.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 5),
        Text(
          value!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        Divider(color: AppColors.primaryColor, thickness: 0.2),
      ],
    );
  }
}
