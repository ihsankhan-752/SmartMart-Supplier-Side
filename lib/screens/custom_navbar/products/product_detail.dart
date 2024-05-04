import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic data;
  const ProductDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = data['productImages'];
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(data['pdtName'], style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Swiper(
                pagination: SwiperPagination(
                  builder: SwiperPagination.fraction,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(images[index], fit: BoxFit.fill)),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              "USD ${data['price']}",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${data['quantity']} Pieces available in Stock",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                color: AppColors.primaryWhite,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "------ Item Description------",
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${data['pdtDescription']}",
              textAlign: TextAlign.center,
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryWhite,
              ),
            ),
            ExpansionTile(
              iconColor: AppColors.primaryWhite,
              childrenPadding: EdgeInsets.only(right: 20),
              title: Text(
                "Reviews",
                style: TextStyle(
                  color: AppColors.primaryWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
