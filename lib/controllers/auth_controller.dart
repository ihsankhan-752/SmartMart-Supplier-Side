import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../views/auth/login_screen.dart';
import '../views/custom_navigation_bar/custom_navigation.dart';

class AuthController extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Future<void> signUp({
    BuildContext? context,
    String? email,
    String? password,
    String? fullName,
    String? storeLogo,
    File? selectedImage,
  }) async {
    try {
      setLoading(true);
      _auth.createUserWithEmailAndPassword(email: email!, password: password!).then((value) async {
        FirebaseStorage fs = FirebaseStorage.instance;
        Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(selectedImage!.path)).then((v) async {
          storeLogo = await v.ref.getDownloadURL();
        });
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "userName": fullName,
          "email": email,
          "address": "test address",
          "phone": "",
          "image": storeLogo,
          "isSupplier": true,
        }).whenComplete(() {
          navigateToPage(context!, CustomNavigationBar());
          setLoading(false);
        });
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(e.message!)));

      print(e);
    }
  }

  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      setLoading(true);
      _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        navigateToPage(context, CustomNavigationBar());
        setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    _auth.signOut().then((value) {
      navigateToPage(context, LoginScreen());
    });
  }
}
