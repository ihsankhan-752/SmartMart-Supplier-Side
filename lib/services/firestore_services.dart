import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/custom_msg.dart';

class FireStoreServices {
  Future<void> updateUserName(BuildContext context, String username) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "userName": username,
      });
      Navigator.of(context).pop();
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
  }

  Future<void> updatePhoneNumber(BuildContext context, String phone) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "phone": phone,
      });
      Navigator.of(context).pop();
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
  }

  Future<void> updateAddress(BuildContext context, String address) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "address": address,
      });
      Navigator.of(context).pop();
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
  }
}
