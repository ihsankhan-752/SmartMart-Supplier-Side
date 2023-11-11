import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';

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
              fontSize: 16,
              color: AppColors.primaryWhite,
            ),
          ),
          Text(
            "$subTitle",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
