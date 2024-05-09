import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_supplier_side/constants/lists.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/controllers/app_text_controller.dart';
import 'package:smart_mart_supplier_side/controllers/loading_controller.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/add_image_widgets.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/add_product_title_value_widget.dart';
import 'package:smart_mart_supplier_side/services/product_services.dart';
import 'package:smart_mart_supplier_side/widgets/buttons.dart';
import 'package:smart_mart_supplier_side/widgets/text_input.dart';

import '../../../constants/colors.dart';
import '../../../controllers/image_controller.dart';
import '../widgets/custom_appbar_header.dart';

class ProductUploadingScreen extends StatefulWidget {
  const ProductUploadingScreen({Key? key}) : super(key: key);

  @override
  State<ProductUploadingScreen> createState() => _ProductUploadingScreenState();
}

class _ProductUploadingScreenState extends State<ProductUploadingScreen> {
  String selectedCategory = "Men";

  AppTextControllers appTextControllers = AppTextControllers();

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarHeader(
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
              title: "Add Products",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Product Images",
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      color: AppColors.primaryBlack,
                      fontSize: 12,
                    ),
                  ),
                  AddImagesWidget(),
                  SizedBox(height: 15),
                  Text(
                    "Select Main Category",
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      color: AppColors.primaryBlack,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: AppColors.mainColor,
                          hint: Text(selectedCategory),
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 18,
                          ),
                          icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.primaryBlack),
                          items: tabs.map((e) {
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
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddProductTitleValueWidget(
                        title: "Product Title",
                        controller: appTextControllers.productTitleController,
                        hintText: 'Kids Jeans',
                      ),
                      AddProductTitleValueWidget(
                        title: "Total Quantity",
                        controller: appTextControllers.productQuantityController,
                        hintText: '120',
                        inputType: TextInputType.number,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddProductTitleValueWidget(
                        title: "Product Price",
                        controller: appTextControllers.productPriceController,
                        hintText: '\$ 22.5',
                        inputType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      AddProductTitleValueWidget(
                        title: "Discount",
                        controller: appTextControllers.productDiscountController,
                        hintText: '5 %',
                        inputType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Product Description",
                    style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                      color: AppColors.primaryBlack,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextInput(
                    maxLines: 5,
                    hintText: 'Kids Jean Specially design for kids for both winter and summer season',
                    controller: appTextControllers.productDescriptionController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: 55,
          child: Consumer<LoadingController>(builder: (context, loadingController, child) {
            return loadingController.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : PrimaryButton(
                    onPressed: () {
                      ProductServices()
                          .uploadProduct(
                        context: context,
                        category: selectedCategory,
                        images: imageController.imageList!,
                        productTitle: appTextControllers.productTitleController.text,
                        productQuantity: int.tryParse(appTextControllers.productQuantityController.text),
                        productPrice: double.tryParse(appTextControllers.productPriceController.text),
                        discount: double.tryParse(appTextControllers.productDiscountController.text) ?? 0.0,
                        description: appTextControllers.productDescriptionController.text,
                      )
                          .whenComplete(() {
                        imageController.imageList!.clear();
                        setState(() {});
                      });
                    },
                    title: "Upload Product",
                  );
          }),
        ),
      ),
    );
  }
}
