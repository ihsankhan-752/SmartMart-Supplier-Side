import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_mart_supplier_side/utils/text_styles.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/editable_profile_widget.dart';
import 'package:smart_mart_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/profile_editing_bottom_sheet.dart';

import '../../../../services/firestore_services.dart';
import '../../../../services/storage_services.dart';
import '../../../../utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.primaryBlack,
        title: Text(
          "Edit Profile Screen",
          style: AppTextStyles.APPBAR_HEADING_STYLE,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Upload New Image",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        selectedImage == null
                            ? CircleAvatar(
                                radius: 65,
                                backgroundImage: NetworkImage(data['image']),
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundImage: FileImage(File(selectedImage!.path)),
                              ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: IconButton(
                              onPressed: () {
                                uploadImage(ImageSource.camera);
                              },
                              icon: selectedImage == null
                                  ? Icon(Icons.camera_alt)
                                  : InkWell(
                                      onTap: () async {
                                        String imageUrl =
                                            await StorageServices().uploadImageToStorage(context, selectedImage);
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .update({
                                          "image": imageUrl,
                                        });
                                        setState(() {
                                          selectedImage = null;
                                        });
                                      },
                                      child: Icon(Icons.check),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Update Name",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: EditableProfileWidget(
                        title: data['userName'],
                        onPressed: () {
                          editableBottomSheet(
                              controller: usernameController,
                              context: context,
                              title: data['userName'],
                              onPressed: () async {
                                await FireStoreServices().updateUserName(context, usernameController.text);
                              });
                        }),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Update Contact",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: EditableProfileWidget(
                      title: data['phone'] == "" ? "No Phone Number Added" : data['phone'],
                      onPressed: () {
                        editableBottomSheet(
                          controller: phoneController,
                          context: context,
                          title: data['phone'],
                          onPressed: () async {
                            await FireStoreServices().updatePhoneNumber(context, phoneController.text);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Update Address",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  EditableProfileWidget(
                    title: data['address'] == "" ? "No Address Added" : data['address'],
                    onPressed: () {
                      editableBottomSheet(
                        controller: addressController,
                        context: context,
                        title: data['address'],
                        onPressed: () async {
                          await FireStoreServices().updateAddress(context, addressController.text);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
