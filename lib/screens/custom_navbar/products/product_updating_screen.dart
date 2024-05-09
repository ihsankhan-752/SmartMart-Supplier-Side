import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/controllers/app_text_controller.dart';
import 'package:smart_mart_supplier_side/controllers/image_controller.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_appbar_header.dart';
import 'package:smart_mart_supplier_side/services/product_services.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';
import 'package:smart_mart_supplier_side/widgets/text_input.dart';

import '../../../constants/colors.dart';
import '../../../model/pdt_model.dart';

class ProductUpdateScreen extends StatefulWidget {
  final ProductModel pdtModel;
  const ProductUpdateScreen({Key? key, required this.pdtModel}) : super(key: key);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  AppTextControllers appTextControllers = AppTextControllers();

  List _newImageList = [];
  List _image = [];

  getAllImages() async {
    _image = widget.pdtModel.pdtImages!;
  }

  @override
  void initState() {
    getAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarHeader(
              title: "Update Product",
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Add New Images",
                    style: AppTextStyles().basicStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
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
                                _newImageList.add(File(imageController.selectedImage!.path));
                              });
                            },
                            child: Icon(Icons.add_circle, color: AppColors.primaryColor, size: 24),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 100,
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _newImageList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 60,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(_newImageList[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.close_sharp, size: 20, color: Colors.red),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Existing Images",
                    style: AppTextStyles().basicStyle,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _image.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 60,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(_image[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                ProductServices().removeSingleImage(
                                  context,
                                  widget.pdtModel.pdtId!,
                                  _image[index],
                                );
                                _image.removeAt(index);
                                setState(() {});
                              },
                              child: Icon(Icons.close_sharp, size: 20, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Product Name",
                    style: AppTextStyles().basicStyle,
                  ),
                  SizedBox(height: 5),
                  CustomTextInput(
                    controller: appTextControllers.productTitleController,
                    hintText: widget.pdtModel.pdtName!,
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: AppTextStyles().basicStyle,
                          ),
                          SizedBox(height: 05),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.28,
                            child: CustomTextInput(
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              hintText: widget.pdtModel.pdtPrice!.toStringAsFixed(1),
                              controller: appTextControllers.productPriceController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: AppTextStyles().basicStyle,
                          ),
                          SizedBox(height: 05),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.28,
                            child: CustomTextInput(
                              inputType: TextInputType.number,
                              controller: appTextControllers.productQuantityController,
                              hintText: widget.pdtModel.quantity!.toString(),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount",
                            style: AppTextStyles().basicStyle,
                          ),
                          SizedBox(height: 05),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: CustomTextInput(
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              controller: appTextControllers.productDiscountController,
                              hintText: widget.pdtModel.discount!.toStringAsFixed(1),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Description",
                    style: AppTextStyles().basicStyle,
                  ),
                  SizedBox(height: 5),
                  CustomTextInput(
                    controller: appTextControllers.productDescriptionController,
                    hintText: widget.pdtModel.pdtDescription!,
                    maxLines: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(15),
        height: 60,
        child: Consumer<LoadingController>(builder: (context, loadingController, child) {
          return loadingController.isLoading
              ? Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : PrimaryButton(
                  onPressed: () {
                    ProductServices().updateProduct(
                      context: context,
                      pdtId: widget.pdtModel.pdtId!,
                      pdtTitle: appTextControllers.productTitleController.text.isEmpty
                          ? widget.pdtModel.pdtName!
                          : appTextControllers.productTitleController.text,
                      pdtDescription: appTextControllers.productDescriptionController.text.isEmpty
                          ? widget.pdtModel.pdtDescription!
                          : appTextControllers.productDescriptionController.text,
                      pdtPrice: appTextControllers.productPriceController.text.isEmpty
                          ? widget.pdtModel.pdtPrice!
                          : double.tryParse(appTextControllers.productPriceController.text)!,
                      quantity: appTextControllers.productQuantityController.text.isEmpty
                          ? widget.pdtModel.quantity!
                          : int.tryParse(appTextControllers.productQuantityController.text)!,
                      discount: appTextControllers.productDiscountController.text.isEmpty
                          ? widget.pdtModel.discount!
                          : double.tryParse(appTextControllers.productDiscountController.text)!,
                      images: _newImageList,
                    );
                  },
                  title: "Save Changes",
                );
        }),
      ),
    );
  }
}
