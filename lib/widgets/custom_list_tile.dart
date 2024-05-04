import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onPressed;
  const CustomListTile({super.key, this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed ?? () {},
          child: ListTile(
            leading: Icon(icon, color: AppColors.primaryBlack),
            title: Text(title!,
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 15,
                  color: AppColors.primaryBlack,
                )),
          ),
        ),
        Divider(color: AppColors.primaryColor, thickness: 0.5, height: 0.2),
      ],
    );
  }
}
