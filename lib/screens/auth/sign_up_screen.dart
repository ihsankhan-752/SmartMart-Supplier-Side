import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/app_text_controller.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/screens/auth/widgets/footer.dart';
import 'package:smart_mart_supplier_side/services/auth_services.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AppTextControllers appTextControllers = AppTextControllers();
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 100),
                LogoWidget(fontSize: 30),
                SizedBox(height: 25),
                Text("Username", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(controller: appTextControllers.fullNameController, hintText: "supplier one"),
                SizedBox(height: 12),
                Text("E-Mail", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(controller: appTextControllers.emailController, hintText: "supplier@gmail.com"),
                SizedBox(height: 12),
                Text("Contact", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(
                  controller: appTextControllers.contactController,
                  inputType: TextInputType.number,
                  hintText: "123456987",
                ),
                SizedBox(height: 12),
                Text("Address", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(controller: appTextControllers.addressController, hintText: "California,USA"),
                SizedBox(height: 12),
                Text("Password", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 14)),
                SizedBox(height: 3),
                CustomTextInput(
                  controller: appTextControllers.passwordController,
                  hintText: "*******",
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
                SizedBox(height: 35),
                Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return loadingController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : PrimaryButton(
                          onPressed: () {
                            AuthServices().signUp(
                              context: context,
                              sellerName: appTextControllers.fullNameController.text,
                              email: appTextControllers.emailController.text,
                              contact: int.tryParse(appTextControllers.contactController.text),
                              address: appTextControllers.addressController.text,
                              password: appTextControllers.passwordController.text,
                            );
                            AppTextControllers().clear();
                          },
                          width: MediaQuery.of(context).size.width * 0.88,
                          btnColor: AppColors.primaryColor,
                          title: "Next",
                        );
                }),
                SizedBox(height: 25),
                Footer(
                  screenName: LoginScreen(),
                  title: "Already Have an Account? ",
                  subTitle: "Sign In",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
