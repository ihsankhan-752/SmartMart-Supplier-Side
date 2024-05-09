import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/model/pdt_model.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';
import 'package:uuid/uuid.dart';

import '../constants/image_compressor.dart';

class ProductServices {
  Future<void> uploadProduct({
    required BuildContext context,
    required String category,
    List<File>? images,
    required String productTitle,
    int? productQuantity,
    double? productPrice,
    double? discount,
    required String description,
  }) async {
    if (images!.isEmpty) {
      showCustomMessage(context, 'images required');
    } else if (productTitle.isEmpty) {
      showCustomMessage(context, 'Product Title required');
    } else if (productQuantity == null) {
      showCustomMessage(context, 'Total quantity required');
    } else if (productPrice == null) {
      showCustomMessage(context, 'Product price required');
    } else if (description.isEmpty) {
      showCustomMessage(context, "Product description required");
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        var productId = const Uuid().v4();

        List<String> _imageUrls = [];
        for (var image in images) {
          File _compressImage = await compressImage(image);
          FirebaseStorage fs = FirebaseStorage.instance;
          Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
          await ref.putFile(File(_compressImage.path));
          String imageUrl = await ref.getDownloadURL();
          _imageUrls.add(imageUrl);
        }

        ProductModel productModel = ProductModel(
          sellerId: FirebaseAuth.instance.currentUser!.uid,
          pdtId: productId,
          pdtImages: _imageUrls,
          pdtName: productTitle,
          category: category,
          quantity: productQuantity,
          pdtPrice: productPrice,
          discount: discount,
          pdtDescription: description,
        );
        await FirebaseFirestore.instance.collection('products').doc(productId).set(productModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMessage(context, e.message!);
      }
    }
  }

  Future<void> updateProduct({
    required BuildContext context,
    required String pdtId,
    required String pdtTitle,
    required String pdtDescription,
    required double pdtPrice,
    required int quantity,
    required double discount,
    required List images,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);

      List<String> _imageUrls = [];
      for (var image in images) {
        File _compressImage = await compressImage(image);
        FirebaseStorage fs = FirebaseStorage.instance;
        Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(File(_compressImage.path));
        String imageUrl = await ref.getDownloadURL();
        _imageUrls.add(imageUrl);
      }

      await FirebaseFirestore.instance.collection('products').doc(pdtId).update({
        'pdtName': pdtTitle,
        'pdtDescription': pdtDescription,
        'discount': discount,
        'pdtPrice': pdtPrice,
        'quantity': quantity,
        'pdtImages': FieldValue.arrayUnion(_imageUrls),
      });
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      showCustomMessage(context, e.message!);
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
    }
  }

  removeSingleImage(BuildContext context, String productId, String imageId) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update(
        {
          'pdtImages': FieldValue.arrayRemove([imageId])
        },
      );
    } on FirebaseException catch (e) {}
  }
}
