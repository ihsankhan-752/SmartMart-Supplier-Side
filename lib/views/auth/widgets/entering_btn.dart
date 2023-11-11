import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class EnteringButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  const EnteringButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.amber,
        ),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              color: AppColors.primaryBlack,
            ),
          ),
        ),
      ),
    );
  }
}
