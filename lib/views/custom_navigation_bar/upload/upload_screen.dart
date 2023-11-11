import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/colors.dart';
import '../../../utils/lists.dart';
import '../../../utils/text_input_decoration.dart';
import '../../../utils/text_styles.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isLoading = false;
  String pdtId = '';
  String pdtName = '';
  String pdtDescription = '';
  double price = 0.0;
  int discount = 0;
  int quantity = 0;

  List<String> imageUrlList = [];
  GlobalKey<FormState> _key = GlobalKey();
  String selectedCategory = "men";
  List<XFile>? imageFileList;

  ImagePicker _picker = ImagePicker();
  Future<void> uploadProductImages() async {
    final pickedImages = await _picker.pickMultiImage(
      imageQuality: 95,
      maxHeight: 300,
      maxWidth: 300,
    );
    setState(() {
      imageFileList = pickedImages;
    });
  }

  Future<void> uploadProductData() async {
    pdtId = Uuid().v4();
    if (imageFileList!.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });
        for (var _image in imageFileList!) {
          FirebaseStorage fs = FirebaseStorage.instance;
          Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
          await ref.putFile(File(_image.path));
          await ref.getDownloadURL();
          imageUrlList.add(await ref.getDownloadURL());
        }
        await FirebaseFirestore.instance.collection("products").doc(pdtId).set({
          "pdtId": pdtId,
          "supplierId": FirebaseAuth.instance.currentUser!.uid,
          "category": selectedCategory,
          "productImages": imageUrlList,
          "pdtName": pdtName,
          "pdtDescription": pdtDescription,
          "discount": 0,
          "quantity": quantity,
          "price": price,
        });
        setState(() {
          isLoading = false;
        });
        imageUrlList = [];
        imageFileList = [];
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Upload Images")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          title: Text("Upload", style: AppTextStyles.APPBAR_HEADING_STYLE),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: AppColors.mainColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: imageFileList == null
                          ? Text(
                              "No Photo to preview",
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                              ),
                            )
                          : ListView.builder(
                              itemCount: imageFileList!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.all(05),
                                  child: Image.file(File(imageFileList![index].path), fit: BoxFit.cover),
                                );
                              },
                            ),
                    ),
                  ),
                  Divider(color: AppColors.mainColor, thickness: 1.5),
                  SizedBox(height: 20),
                  Text(
                    "Select Main Category",
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: AppColors.mainColor,
                    value: selectedCategory.isEmpty ? Text("No Category is Selected") : selectedCategory,
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 18,
                    ),
                    icon: Icon(Icons.arrow_downward, color: AppColors.primaryWhite),
                    items: allCategories.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        selectedCategory = v.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (v) {
                            setState(() {
                              price = double.parse(v!);
                            });
                          },
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Price Must be Filled";
                            } else {
                              return null;
                            }
                          },
                          decoration: textInputDecoration.copyWith(hintText: "Price"),
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: textInputDecoration.copyWith(hintText: "Discount"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (v) {
                      setState(() {
                        quantity = int.parse(v!);
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter Product Quantity";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(hintText: "Quantity"),
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                    ),
                    onSaved: (v) {
                      setState(() {
                        pdtName = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Product Name must be given";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(hintText: "Product Name"),
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                    ),
                    onSaved: (v) {
                      setState(() {
                        pdtDescription = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Description must be given";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 3,
                    maxLength: 100,
                    decoration: textInputDecoration.copyWith(hintText: "Description"),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  uploadProductImages();
                },
                child: Icon(Icons.photo, color: AppColors.primaryWhite),
                backgroundColor: AppColors.primaryColor),
            SizedBox(width: 10),
            FloatingActionButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          uploadProductData().then((value) {
                            _key.currentState!.reset();
                          });
                        } else {
                          print("Not Valid State");
                        }
                      },
                child: isLoading ? CircularProgressIndicator() : Icon(Icons.upload, color: AppColors.primaryWhite),
                backgroundColor: AppColors.primaryColor),
          ],
        ));
  }
}
