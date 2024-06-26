import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/app_assets.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/main.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/product_uploading_screen.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/widgets/all_categories.dart';

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
    return Column(
      children: [
        CustomAppBarHeader(
          widget: SizedBox(height: 20, width: 20, child: Image.asset(AppAssets.products)),
          title: "Products",
          suffixWidget: TextButton(
            onPressed: () {
              navigateToPage(context, ProductUploadingScreen());
            },
            child: Text(
              "Add Products",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentIndex == 0) AllCategories(),
          ],
        ),
      ],
    );
  }
}
