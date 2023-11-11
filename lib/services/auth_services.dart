import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/services/storage_services.dart';
import 'package:smart_mart_supplier_side/utils/custom_msg.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../views/custom_navigation_bar/custom_navigation.dart';

class AuthServices {
  Future<String> signUp(
      {BuildContext? context, String? email, String? password, String? username, File? selectedImage}) async {
    String response = "";
    try {
      var _auth = FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      String image = await StorageServices().uploadImageToStorage(context!, selectedImage);
      UserModel userModel = UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: email,
        username: username,
        image: image,
        isSuppler: false,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toMap());
      response = 'success';
      navigateToPage(context, CustomNavigationBar());
    } on FirebaseException catch (e) {
      response = e.message.toString();
    }
    return response;
  }

  signIn(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomMessage(context, 'All Fields are Required');
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        navigateToPage(context, CustomNavigationBar());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMessage(context, e.message!);
      }
    }
  }
}
