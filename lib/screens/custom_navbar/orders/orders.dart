import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/order_card.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/orders/widgets/order_filter_widget.dart';

import '../../../constants/text_styles.dart';
import '../../../model/order_model.dart';
import '../widgets/custom_appbar_header.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ValueNotifier<String> _orderStatus = ValueNotifier<String>("all");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarHeader(
          title: "Orders",
          widget: SizedBox(height: 20, width: 20, child: Image.asset(AppAssets.orders)),
          suffixWidget: OrdersFilterWidget(orderStatusNotifier: _orderStatus),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: ValueListenableBuilder<String>(
            valueListenable: _orderStatus,
            builder: (context, orderStatus, _) {
              return StreamBuilder<QuerySnapshot>(
                stream: orderStatus == 'all'
                    ? FirebaseFirestore.instance
                        .collection("orders")
                        .where("sellerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("orders")
                        .where("sellerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where('orderStatus', isEqualTo: orderStatus)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Sorry ! No Order Found",
                        style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      OrderModel orderModel = OrderModel.fromMap(snapshot.data!.docs[index]);

                      return OrderCard(orderModel: orderModel);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
