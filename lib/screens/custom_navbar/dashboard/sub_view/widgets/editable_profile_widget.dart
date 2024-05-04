import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class EditableProfileWidget extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const EditableProfileWidget({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.mainColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            Spacer(),
            IconButton(onPressed: onPressed, icon: Icon(Icons.edit), color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
