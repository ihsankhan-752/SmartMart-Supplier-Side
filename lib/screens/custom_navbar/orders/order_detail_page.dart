import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/controllers/seller_controller.dart';
import 'package:smart_mart_supplier_side/model/order_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/customer_information_card.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/product_information_card.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/production_images_portion.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_appbar_header.dart';
import 'package:smart_mart_supplier_side/services/order_services.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';
import 'package:smart_mart_supplier_side/widgets/custom_msg.dart';

import '../../../constants/colors.dart';

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
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.orderModel.orderStatus != 'cancel')
                            SmallButton(
                              onPressed: () {
                                if (widget.orderModel.orderStatus == 'preparing') {
                                  OrderServices.updateOrderStatus(
                                    context: context,
                                    orderId: widget.orderModel.orderId!,
                                    orderStatus: 'shipment',
                                    customerId: widget.orderModel.customerId!,
                                    notificationBody: "Your Order is Ready for Shipment",
                                  );
                                } else if (widget.orderModel.orderStatus == 'shipment') {
                                  OrderServices.updateOrderStatus(
                                    context: context,
                                    orderId: widget.orderModel.orderId!,
                                    orderStatus: 'deliver',
                                    customerId: widget.orderModel.customerId!,
                                    notificationBody: "Your Order is Deliver on your address please pick",
                                  );
                                } else {
                                  showCustomMessage(context, "Order Delivered");
                                }
                              },
                              width: widget.orderModel.orderStatus == 'deliver' ? Get.width - 30 : Get.width * 0.43,
                              height: 50,
                              btnColor: AppColors.primaryColor,
                              textColor: AppColors.primaryWhite,
                              title: widget.orderModel.orderStatus == 'preparing'
                                  ? "Proceed for Shipment"
                                  : widget.orderModel.orderStatus == 'shipment'
                                      ? 'Proceed To Deliver'
                                      : "Delivered",
                            )
                          else
                            SmallButton(
                              onPressed: () {
                                showCustomMessage(context, "Order Canceled");
                              },
                              height: 50,
                              width: Get.width - 30,
                              btnColor: Colors.red[700],
                              textColor: AppColors.primaryWhite,
                              title: "Order Canceled",
                            ),
                          if (widget.orderModel.orderStatus == 'preparing' || widget.orderModel.orderStatus == 'shipment')
                            SmallButton(
                              onPressed: () {
                                OrderServices.updateOrderStatus(
                                  context: context,
                                  orderId: widget.orderModel.orderId!,
                                  orderStatus: 'cancel',
                                  customerId: widget.orderModel.customerId!,
                                  notificationBody: "We Cancel your order Sorry",
                                );
                              },
                              height: 50,
                              width: Get.width * 0.43,
                              btnColor: Colors.red[700],
                              textColor: AppColors.primaryWhite,
                              title: "Cancel Order",
                            )
                          else
                            SizedBox(),
                        ],
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
