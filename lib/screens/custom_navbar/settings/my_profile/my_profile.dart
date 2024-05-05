import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/settings/my_profile/widgets/show_edit_profile_widget.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/settings/my_profile/widgets/title_value_widget.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';

import '../../../../constants/app_assets.dart';
import '../../../../controllers/image_controller.dart';
import '../../../../controllers/seller_controller.dart';
import '../../widgets/custom_appbar_header.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerController = Provider.of<SellerController>(context);
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBarHeader(
              title: "My Profile",
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: sellerController.sellerModel.image == ""
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryColor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Image.asset(AppAssets.profileIcon, color: AppColors.primaryWhite),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: -10,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       imageController.uploadImage(ImageSource.gallery);
                        //     },
                        //     child: CircleAvatar(
                        //       radius: 18,
                        //       backgroundColor: AppColors.primaryWhite,
                        //       child: Center(
                        //         child: Icon(Icons.image, size: 20),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  : Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(sellerController.sellerModel.image!),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -10,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primaryWhite,
                            child: Center(
                              child: Icon(Icons.image, size: 20),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleValueWidget(title: "Name", value: sellerController.sellerModel.sellerName!),
                    TitleValueWidget(title: "E-mail", value: sellerController.sellerModel.email!),
                    TitleValueWidget(title: "Contact", value: sellerController.sellerModel.phone!.toString()),
                    TitleValueWidget(title: "Address", value: sellerController.sellerModel.address!),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: PrimaryButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ShowEditProfileWidget(sellerModel: sellerController.sellerModel);
                      });
                },
                title: "Edit Profile",
                btnColor: AppColors.primaryColor,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
