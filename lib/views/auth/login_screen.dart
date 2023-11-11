import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/views/auth/forgot_password_screen.dart';
import 'package:smart_mart_supplier_side/views/auth/sign_up_screen.dart';
import 'package:smart_mart_supplier_side/views/auth/widgets/footer.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/text_input.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                LogoWidget(),
                Center(
                  child: Text(
                    "Supplier Login",
                    style: AppTextStyles.MAIN_SPLASH_HEADING.copyWith(
                      fontSize: 22,
                      fontFamily: 'pacifico',
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                AuthTextInput(controller: emailController, hintText: "Email"),
                SizedBox(height: 15),
                AuthTextInput(controller: passwordController, hintText: "Password"),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPage(context, ForgotPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                loadingController.isLoading
                    ? CircularProgressIndicator()
                    : PrimaryButton(
                        onPressed: () async {
                          await AuthServices().signIn(context, emailController.text, passwordController.text);
                        },
                        width: MediaQuery.of(context).size.width * 0.85,
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
