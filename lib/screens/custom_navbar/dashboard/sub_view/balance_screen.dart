import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 5,
        centerTitle: true,
        title: Text(
          "Total Balance",
          style: AppTextStyles.APPBAR_HEADING_STYLE,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )),
              child: Center(
                child: Text(
                  "TOTAL BALANCE",
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    fontSize: 20,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where("supplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Order! No Balance"),
                  );
                }
                double sum = 0.0;
                for (var amount in snapshot.data!.docs) {
                  sum += amount['orderQuantity'] * amount['orderPrice'];
                }
                return Center(
                  child: Text(
                    "${sum.toString()} \$",
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      fontSize: 26,
                      color: Colors.amber,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
