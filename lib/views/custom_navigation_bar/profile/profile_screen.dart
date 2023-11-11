import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/controllers/user_controller.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/utils/text_styles.dart';
import 'package:smart_mart_supplier_side/views/auth/login_screen.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/chat/customer_list.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/edit_profile_screen.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/profile/notification_screen.dart';

import '../../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text("Profile", style: AppTextStyles.APPBAR_HEADING_STYLE),
        actions: [
          InkWell(
              onTap: () {
                navigateToPage(context, NotificationScreen());
              },
              child: Icon(Icons.notification_important, color: AppColors.primaryWhite)),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(userController.userImage),
            ),
          ),
          SizedBox(height: 10),
          Text(
            userController.username,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryWhite,
            ),
          ),
          SizedBox(height: 4),
          Divider(color: AppColors.mainColor, thickness: 2, height: 0.7),
          SizedBox(height: 20),
          ListTile(
            onTap: () {
              navigateToPage(context, CustomChatList());
            },
            leading: Icon(Icons.message, color: AppColors.primaryWhite),
            title: Text(
              "Chat",
              style: TextStyle(
                color: AppColors.primaryWhite,
              ),
            ),
          ),
          Divider(color: AppColors.mainColor, thickness: 2, height: 0.7),
          ListTile(
            onTap: () {
              navigateToPage(context, EditProfileScreen());
            },
            leading: Icon(Icons.edit, color: AppColors.primaryWhite),
            title: Text(
              "Update Profile",
              style: TextStyle(
                color: AppColors.primaryWhite,
              ),
            ),
          ),
          Divider(color: AppColors.mainColor, thickness: 2, height: 0.7),
          SizedBox(height: 10),
          ListTile(
            onTap: () async {
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
            leading: Icon(Icons.logout, color: AppColors.primaryWhite),
            title: Text(
              "LogOut",
              style: TextStyle(
                color: AppColors.primaryWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
