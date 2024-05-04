import 'package:flutter/material.dart';

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final String? image, title;
  final Color? iconColor;
  const CustomWidgetSelection({Key? key, this.onPressed, this.image, this.iconColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 22,
            width: 25,
            child: Image.asset(image!, color: iconColor),
          ),
          SizedBox(height: 05),
          Text(
            title!,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Mirador',
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
