import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/model/pdt_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/product_card.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("products")
            .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Center(
                child: Text(
                  "No Data Found!!",
                  style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              ProductModel productModel = ProductModel.fromMap(snapshot.data!.docs[index]);
              return ProductCard(productModel: productModel);
            },
          );
        },
      ),
    );
  }
}
