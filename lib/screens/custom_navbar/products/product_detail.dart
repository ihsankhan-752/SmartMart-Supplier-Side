import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/model/pdt_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/widgets/custom_appbar_header.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarHeader(
            title: "Product Details",
            widget: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: productModel.pdtImages!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(productModel.pdtImages![index], fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "USD ${productModel.pdtPrice}",
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${productModel.quantity} Pieces available in Stock",
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    fontSize: 16,
                    color: AppColors.primaryBlack,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "${productModel.pdtDescription}",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
