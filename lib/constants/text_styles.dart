import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  TextStyle basicStyle = TextStyle(
    fontSize: 14,
    color: AppColors.primaryBlack,
    fontFamily: 'Mirador',
    fontWeight: FontWeight.bold,
  );
  TextStyle H1 = GoogleFonts.patuaOne(
    fontSize: 32,
    color: Colors.white,
  );
  TextStyle H2 = GoogleFonts.patuaOne(
    fontSize: 32,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  TextStyle subHeading = GoogleFonts.montserrat(
    fontSize: 15,
    color: Colors.white,
  );
  static TextStyle MAIN_SPLASH_HEADING = GoogleFonts.pacifico(
    textStyle: TextStyle(
      color: AppColors.primaryBlack,
      fontSize: 45,
      letterSpacing: 1.5,
    ),
  );
  static TextStyle FASHION_STYLE = TextStyle(
    color: AppColors.primaryWhite,
    fontSize: 22,
  );
  static TextStyle APPBAR_HEADING_STYLE = GoogleFonts.acme(
    textStyle: TextStyle(
      color: AppColors.primaryBlack,
      letterSpacing: 0.8,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
  static TextStyle TAB_BAR_ITEM_STYLE = GoogleFonts.acme(
    textStyle: TextStyle(
      letterSpacing: 0.8,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
  static TextStyle DASHBOARD_MENU_STYLE = GoogleFonts.acme(
    textStyle: TextStyle(
      color: AppColors.amber,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.6,
    ),
  );
}
