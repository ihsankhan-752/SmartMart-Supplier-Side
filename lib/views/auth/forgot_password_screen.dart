import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_supplier_side/utils/colors.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/text_input.dart';
import '../../utils/custom_msg.dart';

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
      backgroundColor: AppColors.primaryBlack,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            SizedBox(height: 20),
            Text(
              "Reset Password",
              style: GoogleFonts.pacifico(
                fontSize: 22,
                color: AppColors.primaryWhite,
              ),
            ),
            SizedBox(height: 20),
            AuthTextInput(controller: emailController, hintText: "E-mail"),
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
