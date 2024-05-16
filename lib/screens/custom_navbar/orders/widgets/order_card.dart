import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';

import '../../../../constants/colors.dart';
import 'order_title_value_widget.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;
  const OrderCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < orderModel.productNames!.length; i++) ...[
            Container(
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
                          title: "Product- ",
                          value: orderModel.productNames![i],
                          icon: Icons.production_quantity_limits_sharp,
                        ),
                        OrderTitleValueWidget(
                          title: "Date- ",
                          value: DateFormat('dd MMMM yyyy').format(orderModel.orderDate!),
                          icon: Icons.calendar_month_outlined,
                        ),
                        OrderTitleValueWidget(
                          title: "Payment Status- ",
                          value: orderModel.paymentStatus == 'Card' ? "Paid" : "Unpaid",
                          icon: Icons.credit_card,
                        ),
                        OrderTitleValueWidget(
                          title: "Delivery Status- ",
                          value: orderModel.orderStatus,
                          icon: Icons.fire_truck_sharp,
                          valueColor: orderModel.orderStatus == 'preparing'
                              ? Colors.teal.withOpacity(0.7)
                              : orderModel.orderStatus == 'deliver'
                                  ? Colors.green
                                  : Colors.blue,
                        ),
                      ],
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$ " + orderModel.productPrices![i].toString() + " x " + orderModel.productQuantities![i].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
