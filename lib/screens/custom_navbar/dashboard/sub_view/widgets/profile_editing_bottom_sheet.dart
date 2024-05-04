import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../widgets/buttons.dart';

editableBottomSheet({BuildContext? context, String? title, Function()? onPressed, TextEditingController? controller}) async {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context!,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: title!,
                  ),
                ),
                SizedBox(height: 20),
                PrimaryButton(title: "Save", onPressed: onPressed, width: 200, btnColor: AppColors.darkGrey),
              ],
            ),
          ),
        );
      });
}
