import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/text_styles.dart';

class DashBoardScreenCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onPressed;
  const DashBoardScreenCard({Key? key, this.title, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: AppColors.primaryColor),
            SizedBox(height: 20),
            Text(
              title!,
              style: AppTextStyles.DASHBOARD_MENU_STYLE.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
