import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../model/order_model.dart';
import '../../../widgets/buttons.dart';
import '../widgets/custom_appbar_header.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentIndex = 0;
  String orderStatus = "preparing";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarHeader(
          title: "Orders",
          widget: SizedBox(height: 20, width: 20, child: Image.asset(AppAssets.orders)),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: Get.height * 0.07,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  btnColor: _currentIndex == 0 ? AppColors.primaryWhite : AppColors.grey.withOpacity(0.0),
                  title: "Ongoing",
                  textColor: _currentIndex == 0 ? AppColors.primaryBlack : AppColors.grey.withOpacity(0.8),
                  width: Get.width * 0.27,
                  height: 40,
                ),
                SmallButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  btnColor: _currentIndex == 1 ? AppColors.primaryWhite : AppColors.grey.withOpacity(0.0),
                  title: "Shipment",
                  textColor: _currentIndex == 1 ? AppColors.primaryBlack : AppColors.grey.withOpacity(0.8),
                  width: Get.width * 0.27,
                  height: 40,
                ),
                SmallButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                  btnColor: _currentIndex == 2 ? AppColors.primaryWhite : AppColors.grey.withOpacity(0.0),
                  title: "Deliver",
                  textColor: _currentIndex == 2 ? AppColors.primaryBlack : AppColors.grey.withOpacity(0.8),
                  width: Get.width * 0.27,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("orders")
                .where("sellerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('orderStatus', isEqualTo: getOrderStatus())
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "Sorry ! No Order Found",
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = OrderModel.fromMap(snapshot.data!.docs[index]);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < orderModel.productNames!.length; i++) ...[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 05),
                            height: 100,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(orderModel.productImages![i]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(orderModel.productNames![i], style: AppTextStyles().H2.copyWith(fontSize: 16)),
                                        SizedBox(height: 5),
                                        Text(
                                          "x ${orderModel.productQuantities![i].toString()}",
                                          style: AppTextStyles().H2.copyWith(fontSize: 12, color: AppColors.grey),
                                        ),
                                        Spacer(),
                                        Text("\$ " + orderModel.productPrices![i].toString(),
                                            style: AppTextStyles().H2.copyWith(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: SmallButton(
                                        onPressed: () {},
                                        btnColor: AppColors.primaryColor,
                                        title: orderModel.orderStatus!.toUpperCase(),
                                        textColor: AppColors.primaryWhite,
                                        width: 80,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String getOrderStatus() {
    if (_currentIndex == 0) {
      orderStatus = 'preparing';
    }
    if (_currentIndex == 1) {
      orderStatus = 'complete';
    }
    return orderStatus;
  }
}
