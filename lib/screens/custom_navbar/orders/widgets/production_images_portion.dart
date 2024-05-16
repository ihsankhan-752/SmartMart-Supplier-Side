import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';

import '../../../../constants/colors.dart';

class ProductImagesPortion extends StatelessWidget {
  final OrderModel orderModel;
  const ProductImagesPortion({super.key, required this.orderModel});

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
            Text("Product Images", style: AppTextStyles().H2.copyWith(fontSize: 16, color: AppColors.grey)),
            SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: Get.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: orderModel.productImages!.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(e, fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
