import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

import '../main.dart';
import '../model/seller_model.dart';
import '../screens/custom_navbar/custom_navbar.dart';
import '../screens/store/store_adding_screen.dart';

class AuthServices {
  Future<void> signUp({
    BuildContext? context,
    String? email,
    String? password,
    String? sellerName,
    String? address,
    int? contact,
  }) async {
    if (sellerName!.isEmpty || email!.isEmpty || contact == null || address!.isEmpty || password!.isEmpty) {
      showCustomMessage(context!, "All Fields required");
    } else {
      try {
        Provider.of<LoadingController>(context!, listen: false).setLoading(true);

        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        SellerModel supplierModel = SellerModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          sellerName: sellerName,
          image: "",
          address: address,
          phone: contact,
          memberSince: DateTime.now(),
        );
        await FirebaseFirestore.instance
            .collection("sellers")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(supplierModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        navigateToPage(context, StoreAddingScreen());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context!, listen: false).setLoading(false);
        showCustomMessage(context, e.message!);
      }
    }
  }

  signIn(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomMessage(context, 'All Fields are Required');
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        navigateToPage(context, CustomNavBar());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMessage(context, e.message!);
      }
    }
  }
}
