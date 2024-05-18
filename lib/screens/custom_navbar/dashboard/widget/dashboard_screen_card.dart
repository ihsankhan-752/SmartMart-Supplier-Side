import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';

class DashBoardScreenCard extends StatelessWidget {
  final String? title;
  final String? quantity;
  final Function()? onPressed;
  final IconData? icon;
  final Widget? quantityWidget;
  const DashBoardScreenCard({Key? key, this.title, this.onPressed, this.icon, this.quantity, this.quantityWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.sizeOf(context).width * 0.42,
        height: MediaQuery.sizeOf(context).width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor.withOpacity(.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: AppTextStyles.DASHBOARD_MENU_STYLE.copyWith(
                      color: AppColors.primaryBlack,
                      fontSize: 18,
                      fontFamily: 'Mirador',
                    ),
                  ),
                  Icon(icon, size: 30, color: AppColors.primaryBlack),
                ],
              ),
              SizedBox(height: 20),
              quantityWidget ??
                  Text(
                    quantity!,
                    style: AppTextStyles.DASHBOARD_MENU_STYLE.copyWith(
                      color: AppColors.primaryBlack,
                      fontSize: 35,
                      fontFamily: 'Mirador',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
