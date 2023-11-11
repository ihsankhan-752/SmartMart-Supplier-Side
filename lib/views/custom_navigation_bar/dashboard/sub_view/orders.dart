import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/utils/colors.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/deliver_order.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/preparing_order.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/shipment_order.dart';

import '../../../../utils/text_styles.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _currentIndex,
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.primaryWhite,
          ),
          backgroundColor: AppColors.mainColor,
          elevation: 5,
          centerTitle: true,
          title: Text(
            "Orders",
            style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryWhite),
          ),
          bottom: TabBar(
            onTap: (v) {
              setState(() {
                _currentIndex = v;
              });
            },
            indicatorWeight: 3,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Preparing",
                  style: AppTextStyles.FASHION_STYLE.copyWith(
                    color: _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Shipment",
                style: AppTextStyles.FASHION_STYLE.copyWith(
                  color: _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Deliver",
                style: AppTextStyles.FASHION_STYLE.copyWith(
                  color: _currentIndex == 2 ? AppColors.primaryColor : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PreparingOrder(),
            ShipmentOrder(),
            DeliverOrder(),
          ],
        ),
      ),
    );
  }
}
