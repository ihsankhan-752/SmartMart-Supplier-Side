import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_supplier_side/constants/text_styles.dart';
import 'package:smart_mart_supplier_side/model/pdt_model.dart';
import 'package:smart_mart_supplier_side/screens/custom_navbar/products/product_updating_screen.dart';
import 'package:smart_mart_supplier_side/services/product_services.dart';

import '../../../../constants/colors.dart';
import '../../../../main.dart';
import '../product_detail.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(context, ProductDetailScreen(productModel: productModel));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.12,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.09,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(productModel.pdtImages![0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productModel.pdtName!,
                      style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(fontSize: 18),
                    ),
                    Text(
                      productModel.category!,
                      style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                        fontSize: 14,
                        color: AppColors.primaryBlack.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "\$ ${productModel.pdtPrice!.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    PopupMenuButton(onSelected: (v) {
                      if (v == 'edit') {
                        navigateToPage(context, ProductUpdateScreen(pdtModel: productModel));
                      }
                      if (v == 'delete') {
                        showAlertDialog(
                          context: context,
                          content: "Are you sure to remove this product?",
                          onPressed: () {
                            ProductServices().deleteProduct(context, productModel.pdtId!);
                            Navigator.pop(context);
                          },
                        );
                      }
                    }, itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text("Delete"),
                        ),
                      ];
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog({
  required BuildContext context,
  required String content,
  Function()? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text("Wait!"),
        content: Text(content),
        actions: [
          CupertinoActionSheetAction(
            onPressed: onPressed!,
            child: Text("Yes"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      );
    },
  );
}
