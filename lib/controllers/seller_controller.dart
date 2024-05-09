import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_mart_supplier_side/model/seller_model.dart';
import 'package:smart_mart_supplier_side/model/store_model.dart';

class SellerController extends ChangeNotifier {
  SellerModel? _sellerModel;
  SellerModel get sellerModel => _sellerModel!;

  StoreModel? _storeModel;
  StoreModel? get storeModel => _storeModel;
  getSellerInformation() async {
    try {
      await FirebaseFirestore.instance
          .collection('sellers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((snap) {
        if (snap.exists) {
          _sellerModel = SellerModel.fromDocument(snap);
          getSellerStoreInformation(_sellerModel!.uid!);
        } else {
          throw 'No Seller Found';
        }
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getSellerStoreInformation(String sellerId) async {
    await FirebaseFirestore.instance.collection('stores').where('sellerId', isEqualTo: sellerId).snapshots().listen((snap) {
      for (var store in snap.docs) {
        _storeModel = StoreModel.fromMap(store);
      }
      notifyListeners();
    });
  }
}