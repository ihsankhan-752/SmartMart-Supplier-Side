import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/all_categories.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/kids_category.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/men_category.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/women_category.dart';

import '../widgets/custom_appbar_header.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final sellerController = Provider.of<SellerController>(context).sellerModel;

    return Column(
      children: [
        CustomAppBarHeader(
          widget: SizedBox(height: 20, width: 20, child: Image.asset(AppAssets.products)),
          title: "Products",
          suffixWidget: TextButton(
            onPressed: () {},
            child: Text(
              "Add Products",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_currentIndex == 0) AllCategories(),
                if (_currentIndex == 1) MenCategory(),
                if (_currentIndex == 2) WomenCategory(),
                if (_currentIndex == 3) KidsCategory(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
