import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../widgets/buttons.dart';
import '../../widgets/custom_msg.dart';
import '../../widgets/text_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 16, color: AppColors.primaryBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(fontSize: 30),
            SizedBox(height: 20),
            CustomTextInput(controller: emailController, hintText: "E-mail"),
            SizedBox(height: 20),
            PrimaryButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  showCustomMessage(context, "Enter Email First");
                } else {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                    Navigator.pop(context);
                    showCustomMessage(context, 'Reset Your Password and login again');
                  } on FirebaseAuthException catch (e) {
                    showCustomMessage(context, e.message!);
                  }
                }
              },
              title: "Reset",
              btnColor: AppColors.primaryColor,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
