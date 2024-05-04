import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/widgets/logo_widget.dart';

import '../auth/login_screen.dart';
import '../custom_navbar/custom_navbar.dart';

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
        navigateToPage(context, CustomNavBar());
      } else {
        navigateToPage(context, LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd7d7d7),
      body: LogoWidget(),
    );
  }
}
