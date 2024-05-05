import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class CustomAppBarHeader extends StatelessWidget {
  final String? title;
  final Widget? widget;
  final Widget? suffixWidget;
  const CustomAppBarHeader({super.key, this.title, this.widget, this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                widget ?? SizedBox(),
                SizedBox(width: 20),
                Center(
                  child: Text(
                    title!,
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 18),
                  ),
                ),
                Spacer(),
                suffixWidget ?? SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
