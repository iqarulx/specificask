import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorScheme),
    indicatorColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    fontFamily: 'Inter',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
          color: AppColors.pureWhiteColor, fontSize: 20, fontFamily: 'Inter'),
      iconTheme: IconThemeData(color: AppColors.pureWhiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputDecorationTheme,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    dividerColor: AppColors.grey300,
  );
}

class AppColors {
  static Color colorScheme = const Color(0xffc8102e);
  static Color primaryColor = const Color(0xffc8102e);
  static Color secondaryColor = const Color(0xffe3e8f0);
  static Color whiteColor = const Color(0xffF2F2F2);
  static Color pureWhiteColor = const Color(0xffFFFFFF);
  static Color blackColor = const Color(0xff000000);
  static Color greyColor = const Color(0xff808080);
  static Color scaffoldBackgroundColor = const Color(0xffEEEEEE);
  static Color redColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color transparent = Colors.transparent;
  static Color inputDecorationTheme = const Color(0xfff1f5f9);
  static Color grey300 = Colors.grey.shade300;
  static Color grey100 = Colors.grey.shade100;
  static Color grey500 = Colors.grey.shade500;
  static Color grey400 = Colors.grey.shade400;
  static Color grey600 = Colors.grey.shade600;
  static Color blue50 = Colors.blue.shade50;
  static Color teal = Colors.teal;
  static Color orange = Colors.orange;
  static Color amberColor = Colors.amber;
  static Color amber700 = Colors.amber.shade700;
  static Color black38 = Colors.black38;
  static Color black26 = Colors.black26;
  static Color black12 = Colors.black12;
  static Color white60 = Colors.white60;
  static Color white54 = Colors.white54;
}
