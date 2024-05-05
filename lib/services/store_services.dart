import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/model/store_model.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';
import 'package:uuid/uuid.dart';

import '../screens/custom_navbar/custom_navbar.dart';

class StoreServices {
  static addStore({
    required BuildContext context,
    required String storeName,
    required String storeLocation,
    int? contact,
    required String description,
  }) async {
    if (storeName.isEmpty || storeLocation.isEmpty || contact == null || description.isEmpty) {
      showCustomMessage(context, "All fields are required");
    } else {
      try {
        var storeId = const Uuid().v4();
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        StoreModel storeModel = StoreModel(
          sellerId: FirebaseAuth.instance.currentUser!.uid,
          storeId: storeId,
          storeName: storeName,
          address: storeLocation,
          contact: contact,
          description: description,
          storeLogo: "",
          createdAt: DateTime.now(),
        );
        await FirebaseFirestore.instance.collection('stores').doc(storeId).set(storeModel.toMap());

        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMessage(context, "Account Created Successfully");
        navigateToPage(context, CustomNavBar());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);

        showCustomMessage(context, e.message!);
      }
    }
  }

  updateStoreInformation({
    required BuildContext context,
    required String storeId,
    required String storeName,
    required String address,
    required String description,
    required int contact,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      await FirebaseFirestore.instance.collection('stores').doc(storeId).update({
        'storeName': storeName,
        'address': address,
        'contact': contact,
        'description': description,
      });
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      showCustomMessage(context, e.message!);
    }
  }
}
