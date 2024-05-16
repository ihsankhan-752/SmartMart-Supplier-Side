import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/controllers/seller_controller.dart';

import '../../../../constants/colors.dart';

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<SellerController>(context).userModel;
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
            Text("Customer Information", style: AppTextStyles().H2.copyWith(fontSize: 16, color: AppColors.grey)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Name : " + " " + userController.username!,
                  style: TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Phone : " + " " + userController.phone!.toString(),
                  style: TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Email : " + " " + userController.email!,
                  style: TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: Get.width * 0.8,
                  child: Text(
                    "Address : " + " " + userController.address!,
                    style: TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
