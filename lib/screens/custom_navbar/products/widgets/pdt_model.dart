import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../main.dart';
import '../product_detail.dart';
import '../product_updating_screen.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({Key? key, this.products}) : super(key: key);

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(
            context,
            ProductDetailScreen(
              data: widget.products,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: 200,
                    ),
                    child: Image(image: NetworkImage(widget.products['productImages'][0])),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                    child: Text(
                      widget.products['pdtName'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$ ",
                              style: TextStyle(color: AppColors.primaryWhite),
                            ),
                            Text(
                              widget.products['price'].toStringAsFixed(2),
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        widget.products['supplierId'] == FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {
                                  navigateToPage(
                                      context,
                                      ProductUpdateScreen(
                                        data: widget.products,
                                      ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryWhite,
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
