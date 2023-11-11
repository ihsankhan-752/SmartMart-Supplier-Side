import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  final Widget? child;
  const ScreenBackgroundWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/shopping.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.primaryBlack.withOpacity(0.5),
            BlendMode.srcATop,
          ),
        ),
      ),
      child: child,
    );
  }
}
