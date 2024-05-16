import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class OrdersFilterWidget extends StatelessWidget {
  final ValueNotifier<String> orderStatusNotifier;
  OrdersFilterWidget({super.key, required this.orderStatusNotifier});

  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_alt_outlined, color: AppColors.primaryBlack),
      onSelected: (value) {
        orderStatusNotifier.value = value;
      },
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            value: 'all',
            child: Text("All Orders"),
          ),
          PopupMenuItem(
            value: 'preparing',
            child: Text("Pending"),
          ),
          PopupMenuItem(
            value: 'shipment',
            child: Text("Shipment"),
          ),
          PopupMenuItem(
            value: 'deliver',
            child: Text("Deliver"),
          ),
        ];
      },
    );
  }
}
