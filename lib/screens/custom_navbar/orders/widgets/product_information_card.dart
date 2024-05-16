import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';

import '../../../../constants/colors.dart';

class ProductInformationCard extends StatelessWidget {
  final OrderModel orderModel;
  const ProductInformationCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product Information", style: AppTextStyles().H2.copyWith(fontSize: 16, color: AppColors.grey)),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Product Names:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ...orderModel.productNames!.map((e) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.mainColor),
                            ),
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 12, color: AppColors.primaryBlack, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Product Quantities : ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ...orderModel.productQuantities!.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "x" + e.toString(),
                              style: TextStyle(fontSize: 14, color: AppColors.primaryBlack, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Product Prices : ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ...orderModel.productPrices!.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "\$ " + e.toString(),
                              style: TextStyle(fontSize: 14, color: AppColors.primaryBlack, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
