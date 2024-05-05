import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_widget_selection.dart';

import '../../constants/lists.dart';
import '../../controllers/seller_controller.dart';
import '../../services/notification_services.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  void initState() {
    NotificationServices().initNotification(context);
    NotificationServices().getDeviceToken();
    NotificationServices().getPermission();
    super.initState();
    loadUserData();
  }

  int _currentIndex = 0;

  loadUserData() async {
    await Provider.of<SellerController>(context, listen: false).getSellerInformation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: screens[_currentIndex],
        bottomNavigationBar: Container(
          color: AppColors.primaryColor,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomWidgetSelection(
                  image: AppAssets.dashboardIcon,
                  iconColor: _currentIndex == 0 ? AppColors.primaryBlack : AppColors.primaryWhite.withOpacity(0.6),
                  title: "Dashboard",
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                CustomWidgetSelection(
                  image: AppAssets.products,
                  iconColor: _currentIndex == 1 ? AppColors.primaryBlack : AppColors.primaryWhite.withOpacity(0.6),
                  title: "Products",
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                CustomWidgetSelection(
                  iconColor: _currentIndex == 2 ? AppColors.primaryBlack : AppColors.primaryWhite.withOpacity(0.6),
                  title: "Orders",
                  image: AppAssets.orders,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                CustomWidgetSelection(
                  iconColor: _currentIndex == 3 ? AppColors.primaryBlack : AppColors.primaryWhite.withOpacity(0.6),
                  title: "Chat",
                  image: AppAssets.chatIcon,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
                CustomWidgetSelection(
                  iconColor: _currentIndex == 4 ? AppColors.primaryBlack : AppColors.primaryWhite.withOpacity(0.6),
                  image: AppAssets.settings,
                  title: "Settings",
                  onPressed: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
