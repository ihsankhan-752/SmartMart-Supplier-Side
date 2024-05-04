import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../main.dart';

class Footer extends StatelessWidget {
  final String? title, subTitle;
  final Widget? screenName;
  const Footer({Key? key, this.title, this.subTitle, this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToPage(context, screenName!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlack,
            ),
          ),
          Text(
            "$subTitle",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
