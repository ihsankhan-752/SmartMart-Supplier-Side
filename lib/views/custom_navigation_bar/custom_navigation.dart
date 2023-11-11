import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/user_controller.dart';
import 'package:smart_mart_supplier_side/utils/colors.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/profile/profile_screen.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/upload/upload_screen.dart';

import '../../services/notification_services.dart';
import 'dashboard/dashboard.dart';
import 'home/home_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    NotificationServices().initNotification(context);
    NotificationServices().getDeviceToken();
    NotificationServices().getPermission();
    Provider.of<UserController>(context, listen: false).getUser();
    super.initState();
  }

  int _currentIndex = 0;
  List Pages = [
    HomeScreen(),
    Dashboard(),
    UploadScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        body: Pages[_currentIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(color: AppColors.mainColor, boxShadow: [], borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomWidgetSelection(
                icon: FontAwesomeIcons.house,
                iconColor: _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              CustomWidgetSelection(
                icon: Icons.dashboard,
                iconColor: _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              CustomWidgetSelection(
                iconColor: _currentIndex == 2 ? AppColors.primaryColor : Colors.grey,
                icon: Icons.drive_folder_upload,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              CustomWidgetSelection(
                iconColor: _currentIndex == 3 ? AppColors.primaryColor : Colors.grey,
                icon: Icons.person,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final Color? iconColor;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 25),
          SizedBox(width: 04),
        ],
      ),
    );
  }
}
