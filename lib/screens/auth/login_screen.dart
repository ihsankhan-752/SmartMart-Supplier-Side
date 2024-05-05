import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/screens/auth/sign_up_screen.dart';
import 'package:smart_mart_supplier_side/screens/auth/widgets/footer.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/app_text_controller.dart';
import '../../services/auth_services.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_input.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppTextControllers appTextControllers = AppTextControllers();
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180),
                LogoWidget(fontSize: 30),
                SizedBox(height: 30),
                Text("E-Mail", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(controller: appTextControllers.emailController, hintText: "supplier@gmail.com"),
                SizedBox(height: 15),
                Text("Password", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(
                  controller: appTextControllers.passwordController,
                  hintText: "******",
                  isSecureText: _isVisible,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, ForgotPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                loadingController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        onPressed: () async {
                          await AuthServices().signIn(
                            context,
                            appTextControllers.emailController.text,
                            appTextControllers.passwordController.text,
                          );
                        },
                        width: MediaQuery.of(context).size.width,
                        btnColor: AppColors.primaryColor,
                        title: "Sign In",
                      ),
                SizedBox(height: 20),
                Footer(
                  screenName: SignUpScreen(),
                  title: "Don't Have an Account?",
                  subTitle: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
