import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/settings/change_password/change_password_screen.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/settings/my_store/my_store_screen.dart';

import '../../../constants/colors.dart';
import '../../../controllers/seller_controller.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../auth/login_screen.dart';
import '../widgets/custom_appbar_header.dart';
import 'my_profile/my_profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerController = Provider.of<SellerController>(context).sellerModel;
    return Column(
      children: [
        CustomAppBarHeader(
          title: "Settings",
          widget: SizedBox(
            height: 20,
            width: 25,
            child: Image.asset(AppAssets.settings),
          ),
        ),
        SizedBox(height: 20),
        sellerController.image == ""
            ? Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(AppAssets.profileIcon, color: AppColors.primaryWhite),
                ),
              )
            : Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(sellerController.image ?? " "),
                ),
              ),
        SizedBox(height: 10),
        Text(
          sellerController.sellerName ?? "",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 18),
        ),
        SizedBox(height: 2),
        Text(
          "Member Since ${DateFormat('dd MMMM yyyy').format(sellerController.memberSince!)}",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 13, color: AppColors.grey),
        ),
        SizedBox(height: 20),
        CustomListTile(
          title: "My Profile",
          icon: Icons.person,
          onPressed: () {
            navigateToPage(context, MyProfileScreen());
          },
        ),
        CustomListTile(
          title: "My Store",
          icon: Icons.store,
          onPressed: () {
            navigateToPage(context, MyStoreScreen());
          },
        ),
        CustomListTile(
          title: "Change Password",
          icon: Icons.lock_person_outlined,
          onPressed: () {
            navigateToPage(context, ChangePasswordScreen());
          },
        ),
        CustomListTile(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return CupertinoAlertDialog(
                  title: Text("Wait!"),
                  content: Text("Are you Sure to Logout?"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        navigateToPage(context, LoginScreen());
                      },
                      child: Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          title: "LogOut",
          icon: Icons.logout,
        ),
      ],
    );
  }
}
