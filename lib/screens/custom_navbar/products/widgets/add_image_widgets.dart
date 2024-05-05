import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../controllers/image_controller.dart';

class AddImagesWidget extends StatefulWidget {
  const AddImagesWidget({super.key});

  @override
  State<AddImagesWidget> createState() => _AddImagesWidgetState();
}

class _AddImagesWidgetState extends State<AddImagesWidget> {
  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      imageController.uploadImage(ImageSource.gallery).then((value) {
                        imageController.imageList!.add(File(imageController.selectedImage!.path));
                      });
                    },
                    child: Icon(Icons.add_circle, color: AppColors.primaryColor, size: 24),
                  ),
                ),
              ),
              SizedBox(width: 23),
              Expanded(
                child: Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageController.imageList!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(imageController.imageList![index]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: GestureDetector(
                              onTap: () {
                                imageController.imageList!.removeAt(index);
                                setState(() {});
                              },
                              child: SizedBox(
                                height: 10,
                                width: 10,
                                child: Icon(Icons.close_sharp, color: Colors.red, size: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
