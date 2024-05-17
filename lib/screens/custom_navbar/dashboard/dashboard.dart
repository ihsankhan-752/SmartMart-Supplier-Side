import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/dashboard/widget/dashboard_screen_card.dart';

import '../../../constants/app_assets.dart';
import '../../../main.dart';
import '../chat/customer_list.dart';
import '../orders/orders.dart';
import '../widgets/custom_appbar_header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarHeader(
          widget: Icon(Icons.dashboard),
          title: "Dashboard",
          suffixWidget: SizedBox(
            height: 20,
            width: 25,
            child: Image.asset(AppAssets.notification),
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 5,
            ),
            children: [
              DashBoardScreenCard(
                onPressed: () {
                  navigateToPage(context, OrderScreen());
                },
                icon: Icons.shopping_bag,
                title: "Products",
                quantity: "50",
              ),
              DashBoardScreenCard(
                icon: Icons.grade_outlined,
                title: "Rating",
                onPressed: () {
                  navigateToPage(context, CustomerChatListScreen());
                },
                quantity: "05",
              ),
              DashBoardScreenCard(
                icon: Icons.note_alt_outlined,
                onPressed: () {},
                title: "Total\nOrders",
                quantity: "2k",
              ),
              DashBoardScreenCard(
                onPressed: () {},
                title: "Total\nSales",
                quantity: "1K",
                icon: Icons.bar_chart,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
