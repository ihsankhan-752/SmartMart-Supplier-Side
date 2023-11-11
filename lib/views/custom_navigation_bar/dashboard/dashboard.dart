import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/chat/customer_list.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/balance_screen.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/orders.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/statics.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/widget/dashboard_screen_card.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.primaryBlack,
        iconTheme: IconThemeData(
          color: AppColors.primaryBlack,
        ),
        title: Text("Dashboard", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryWhite)),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        children: [
          DashBoardScreenCard(
              onPressed: () {
                navigateToPage(context, OrderScreen());
              },
              title: "Orders",
              icon: Icons.shop),
          DashBoardScreenCard(
            title: "Chat",
            icon: Icons.chat,
            onPressed: () {
              navigateToPage(context, CustomChatList());
            },
          ),
          DashBoardScreenCard(
              onPressed: () {
                navigateToPage(context, BalanceScreen());
              },
              title: "My Balance",
              icon: Icons.money),
          DashBoardScreenCard(
              onPressed: () {
                navigateToPage(context, Statics());
              },
              title: "Statics",
              icon: Icons.bar_chart),
        ],
      ),
    );
  }
}
