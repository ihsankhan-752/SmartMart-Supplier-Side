import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../widgets/text_input.dart';

class AddProductTitleValueWidget extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? inputType;
  const AddProductTitleValueWidget({super.key, this.title, this.controller, this.hintText, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            color: AppColors.primaryBlack,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.45,
          child: CustomTextInput(
            controller: controller,
            inputType: inputType ?? TextInputType.text,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
