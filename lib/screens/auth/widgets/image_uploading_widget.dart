import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class ImageUploadingWidget extends StatelessWidget {
  final Function()? cameraTapped;
  final Function()? galleryTapped;
  final File? selectedImage;
  const ImageUploadingWidget({Key? key, this.cameraTapped, this.galleryTapped, this.selectedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: AppColors.primaryColor,
          backgroundImage: selectedImage == null ? null : FileImage(selectedImage!),
        ),
        SizedBox(width: 40),
        Column(
          children: [
            Container(
              height: 40,
              width: 45,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              ),
              child: Center(
                child: IconButton(
                  onPressed: cameraTapped,
                  icon: Icon(Icons.camera_alt, color: AppColors.primaryWhite),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 45,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
              ),
              child: Center(
                child: IconButton(
                  onPressed: galleryTapped,
                  icon: Icon(Icons.photo, color: AppColors.primaryWhite),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
