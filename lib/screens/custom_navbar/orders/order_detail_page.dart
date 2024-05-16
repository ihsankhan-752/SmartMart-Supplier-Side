import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/seller_controller.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/customer_information_card.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/product_information_card.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/production_images_portion.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_appbar_header.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel orderModel;

  const OrderDetailScreen({super.key, required this.orderModel});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    _loadCustomerInformation();
    super.initState();
  }

  _loadCustomerInformation() async {
    await Provider.of<SellerController>(context, listen: false).getOtherUserInformation(widget.orderModel.customerId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarHeader(
            widget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
            title: "Order Detail",
          ),
          ProductImagesPortion(orderModel: widget.orderModel),
          ProductInformationCard(orderModel: widget.orderModel),
          CustomerInformationCard(),
        ],
      ),
    );
  }
}
