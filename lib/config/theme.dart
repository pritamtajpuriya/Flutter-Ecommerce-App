import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const double titleFontSize = 34;
  static const double sidePadding = 15;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 10;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const tile_width = 148.0;
  static const tile_height = 276.0;
}

class AppColors {
  static const red = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
}

class CustomTextStyle {
  static get lowVisial =>
      TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14);
  static get price => TextStyle(color: Colors.redAccent, fontSize: 14);
  static get title => TextStyle(color: Colors.black, fontSize: 16);
}

class SajiloTheme {
  static ThemeData of(context) {
    return ThemeData(
        primaryColorLight: AppColors.lightGray,
        accentColor: AppColors.red,
        bottomAppBarColor: AppColors.lightGray,
        backgroundColor: AppColors.background,
        dialogBackgroundColor: AppColors.backgroundLight,
        errorColor: AppColors.red,
        dividerColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: AppColors.black),
            textTheme: TextTheme(
                caption: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ))));
  }
}

class AppWidget {
  static void snacbar(String title) {
    Get.snackbar(title, '',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        borderRadius: 0,
        backgroundColor: Colors.black.withOpacity(0.8),
        isDismissible: true,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(5));
  }
}
