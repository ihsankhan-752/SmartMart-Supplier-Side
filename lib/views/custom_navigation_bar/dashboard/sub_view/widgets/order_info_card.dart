import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/colors.dart';

class OrderInfoCard extends StatelessWidget {
  final String? title;
  final String? value;
  final Function()? onPressed;

  const OrderInfoCard({super.key, this.title, this.value, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Text(
                "${title}:",
                style: GoogleFonts.acme(
                  fontSize: 15,
                  color: AppColors.primaryBlack,
                ),
              ),
              SizedBox(width: 02),
              InkWell(
                onTap: onPressed ?? () {},
                child: SizedBox(
                  width: 220,
                  child: Text(
                    value!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.acme(
                      fontSize: 14,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 0.6)
      ],
    );
  }
}
