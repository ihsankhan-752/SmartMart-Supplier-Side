import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_mart_supplier_side/views/auth/widgets/footer.dart';
import 'package:smart_mart_supplier_side/views/auth/widgets/image_uploading_widget.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/text_input.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../utils/custom_msg.dart';
import '../../utils/text_styles.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

  void signUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty ||
        selectedImage == null) {
      showCustomMessage(context, "Some Filled Are Missing");
    } else {
      setState(() {
        isLoading = true;
      });
      String res = await AuthServices().signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        selectedImage: selectedImage,
      );
      setState(() {
        isLoading = false;
        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        selectedImage = null;
      });
      if (res == 'success') {
        showCustomMessage(context, "User is Created Successfully");
      } else {
        showCustomMessage(context, "User is Not Created Yet");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 100),
                LogoWidget(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Supplier SignUp",
                      style: AppTextStyles.MAIN_SPLASH_HEADING.copyWith(
                        fontSize: 22,
                        fontFamily: 'pacifico',
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                ImageUploadingWidget(
                  cameraTapped: () {
                    uploadImage(ImageSource.camera);
                  },
                  galleryTapped: () {
                    uploadImage(ImageSource.gallery);
                  },
                  selectedImage: selectedImage,
                ),
                SizedBox(height: 25),
                AuthTextInput(controller: usernameController, hintText: "Full Name"),
                SizedBox(height: 15),
                AuthTextInput(controller: emailController, hintText: "Email"),
                SizedBox(height: 15),
                AuthTextInput(controller: passwordController, hintText: "Password"),
                SizedBox(height: 25),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PrimaryButton(
                        onPressed: () {
                          signUp();
                        },
                        width: MediaQuery.of(context).size.width * 0.88,
                        btnColor: AppColors.primaryColor,
                        title: "Sign Up",
                      ),
                SizedBox(height: 15),
                Footer(
                  screenName: LoginScreen(),
                  title: "Already Have an Account",
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
