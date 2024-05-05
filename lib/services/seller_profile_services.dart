import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

class SellerProfileServices {
  Future<void> updateSellerInfo({
    required BuildContext context,
    required String sellerName,
    required int phone,
    required String address,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      await FirebaseFirestore.instance.collection('sellers').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'sellerName': sellerName,
        'address': address,
        'phone': phone,
      });

      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      showCustomMessage(context, e.message!);
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
    }
  }
}
