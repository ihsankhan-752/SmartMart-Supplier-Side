import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/utils/colors.dart';
import 'package:smart_mart_supplier_side/views/auth/login_screen.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/custom_navigation.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      if (FirebaseAuth.instance.currentUser != null) {
        navigateToPage(context, CustomNavigationBar());
      } else {
        navigateToPage(context, LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: LogoWidget(),
    );
  }
}
