import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/colors.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';
import 'package:smart_mart_supplier_side/widgets/text_input.dart';

import '../../../../constants/text_styles.dart';
import '../../../../controllers/image_controller.dart';
import '../../../../controllers/seller_controller.dart';
import '../../../../services/seller_profile_services.dart';
import '../../widgets/custom_appbar_header.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sellerController = Provider.of<SellerController>(context);
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBarHeader(
              title: "Edit Profile",
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (imageController.selectedImage == null && sellerController.sellerModel.image == "")
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.person, size: 45, color: AppColors.primaryWhite),
                    )
                  else if (imageController.selectedImage == null && sellerController.sellerModel.image != "")
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: NetworkImage(sellerController.sellerModel.image!),
                    )
                  else
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryColor,
                      backgroundImage: FileImage(File(imageController.selectedImage!.path)),
                    ),
                  Positioned(
                    bottom: 0,
                    right: -10,
                    child: GestureDetector(
                      onTap: () {
                        imageController.uploadImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                        child: Center(
                          child: Icon(Icons.camera_alt, size: 20, color: AppColors.primaryWhite),
                        ),
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
                    Text("Profile Information", style: AppTextStyles().H2.copyWith(fontSize: 16)),
                    SizedBox(height: 20),
                    Text("Name", style: AppTextStyles().H2.copyWith(fontSize: 14)),
                    SizedBox(height: 10),
                    CustomTextInput(
                      controller: _nameController,
                      hintText: sellerController.sellerModel.sellerName!,
                    ),
                    SizedBox(height: 20),
                    Text("Contact", style: AppTextStyles().H2.copyWith(fontSize: 14)),
                    SizedBox(height: 10),
                    CustomTextInput(
                      inputType: TextInputType.number,
                      controller: _phoneController,
                      hintText: sellerController.sellerModel.phone.toString(),
                    ),
                    SizedBox(height: 20),
                    Text("Address", style: AppTextStyles().H2.copyWith(fontSize: 14)),
                    SizedBox(height: 10),
                    CustomTextInput(
                      controller: _addressController,
                      hintText: sellerController.sellerModel.address,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PrimaryButton(
                        onPressed: () {
                          SellerProfileServices().updateSellerInfo(
                            context: context,
                            sellerName:
                                _nameController.text.isEmpty ? sellerController.sellerModel.sellerName! : _nameController.text,
                            phone: _phoneController.text.isEmpty
                                ? sellerController.sellerModel.phone!
                                : int.tryParse(_phoneController.text)!,
                            address:
                                _addressController.text.isEmpty ? sellerController.sellerModel.address! : _addressController.text,
                            image: imageController.selectedImage,
                          );
                          imageController.removeUploadPhoto();
                        },
                        title: "Save Changes",
                        btnColor: AppColors.primaryColor,
                        width: double.infinity,
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
