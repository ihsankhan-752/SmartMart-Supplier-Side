import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';

import '../widgets/custom_appbar_header.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarHeader(
          title: "Orders",
          widget: SizedBox(height: 20, width: 20, child: Image.asset(AppAssets.orders)),
        )
      ],
    );
  }
}
