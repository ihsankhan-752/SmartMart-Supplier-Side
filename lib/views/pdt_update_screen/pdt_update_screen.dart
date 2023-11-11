import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../custom_widgets/buttons.dart';
import '../../utils/colors.dart';
import '../../utils/text_input_decoration.dart';
import '../../utils/text_styles.dart';
import '../pdt_model.dart';

class ProductUpdateScreen extends StatefulWidget {
  final dynamic data;
  const ProductUpdateScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  late String pdtName;
  late String pdtDescription;
  late int discount;
  late int quantity;
  late double price;
  List<XFile>? imageList;
  GlobalKey<FormState> _key = GlobalKey();
  ImagePicker _picker = ImagePicker();
  Future<void> uploadProductImages() async {
    final uploadImages = await _picker.pickMultiImage(
      imageQuality: 95,
      maxHeight: 300,
      maxWidth: 300,
    );
    setState(() {
      imageList = uploadImages;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    PdtModel pdtModel = PdtModel.fromDocumentSnapshot(widget.data);

    List<String> imageUrlList = [];

    Future<void> uploadProductData() async {
      if (imageList!.isNotEmpty) {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          try {
            setState(() {
              isLoading = true;
            });
            for (var _image in imageList!) {
              FirebaseStorage fs = await FirebaseStorage.instance;
              Reference reference = fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
              await reference.putFile(File(_image.path));
              await reference.getDownloadURL();
              imageUrlList.add(await reference.getDownloadURL());
            }
            await FirebaseFirestore.instance.collection("products").doc(pdtModel.pdtId).update({
              "productImages": imageUrlList,
              "pdtName": pdtName,
              "pdtDescription": pdtDescription,
              "discount": discount,
              "quantity": quantity,
              "price": price,
            });
            setState(() {
              isLoading = false;
            });
            imageUrlList = [];
            imageList = [];
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            print(e);
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(pdtModel.pdtName!, style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: pdtModel.pdtImages!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10), child: Image.network(e, fit: BoxFit.fill)),
                        );
                      }).toList(),
                    )),
              ),
              ExpansionTile(
                trailing: Icon(Icons.arrow_downward, color: AppColors.grey),
                title: Text(
                  "Change Images",
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                  ),
                ),
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.width * 0.45,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: imageList == null
                          ? Center(
                              child: InkWell(
                                  onTap: () {
                                    uploadProductImages();
                                  },
                                  child: Icon(Icons.photo, size: 30, color: AppColors.grey)),
                            )
                          : ListView(
                              children: imageList!.map((e) {
                                return Image.file(File(e.path));
                              }).toList(),
                            ))
                ],
              ),
              Divider(color: Colors.amber, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                        onSaved: (v) {
                          setState(() {
                            price = double.parse(v!);
                          });
                        },
                        initialValue: pdtModel.pdtPrice!.toStringAsFixed(2),
                        decoration: textInputDecoration.copyWith(),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                        onSaved: (v) {
                          setState(() {
                            discount = int.parse(v!);
                          });
                        },
                        maxLength: 2,
                        initialValue: pdtModel.discount!.toString(),
                        decoration: textInputDecoration.copyWith(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                    onSaved: (v) {
                      setState(() {
                        quantity = int.parse(v!);
                      });
                    },
                    initialValue: pdtModel.quantity.toString(),
                    decoration: textInputDecoration.copyWith(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                    onSaved: (v) {
                      setState(() {
                        pdtName = v!;
                      });
                    },
                    maxLength: 100,
                    maxLines: 3,
                    initialValue: pdtModel.pdtName!,
                    decoration: textInputDecoration.copyWith(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                    onSaved: (v) {
                      setState(() {
                        pdtDescription = v!;
                      });
                    },
                    maxLength: 100,
                    maxLines: 3,
                    initialValue: pdtModel.pdtDescription!,
                    decoration: textInputDecoration.copyWith(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    width: 100,
                    title: "Cancel",
                    onPressed: () {},
                  ),
                  SizedBox(width: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MainButton(
                          width: 120,
                          title: "Save Changes",
                          onPressed: () {
                            uploadProductData();
                          },
                        )
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: MainButton(
                  width: 200,
                  title: "Delete this Item",
                  onPressed: () async {
                    FirebaseFirestore.instance.collection("products").doc(pdtModel.pdtId).delete().then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
