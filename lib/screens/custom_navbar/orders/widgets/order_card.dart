import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';

import '../../../../constants/colors.dart';
import '../order_detail_page.dart';
import 'order_title_value_widget.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;
  const OrderCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            Get.to(() => OrderDetailScreen(orderModel: orderModel));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderTitleValueWidget(
                        title: "Products- ",
                        value: Row(
                          children: [
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
                        icon: Icons.production_quantity_limits_sharp,
                      ),
                      OrderTitleValueWidget(
                        title: "Order Date- ",
                        value: Text(
                          DateFormat('dd MMMM yyyy').format(orderModel.orderDate!),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icons.calendar_month_outlined,
                      ),
                      OrderTitleValueWidget(
                        title: "Payment Status- ",
                        value: Text(
                          orderModel.paymentStatus == 'Card' ? "Paid" : "Unpaid",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icons.credit_card,
                      ),
                      OrderTitleValueWidget(
                        title: "Delivery Status- ",
                        value: Text(
                          orderModel.orderStatus!,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icons.fire_truck_sharp,
                      ),
                    ],
                  ),
                  Spacer(),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     "\$ " + orderModel.productPrices![i].toString() + " x " + orderModel.productQuantities![i].toString(),
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //       color: AppColors.primaryBlack,
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
