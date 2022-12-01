import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFFD45555);
const kAppGreyColor = Color(0xffC4C4C4);
const kGreyColor = Color(0xff9d9d9d);
const kErrorColor = Color(0xffEF5350);
const kSuccessColor = Colors.green;

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: Colors.red,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
      accentColor: kPrimaryColor,
      primaryColorDark: kPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: GetPlatform.isMobile ? 20 : 24,
      ),
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          textStyle: TextStyle(
            fontSize: GetPlatform.isAndroid ? 13 : 16,
            fontWeight: FontWeight.w500,
          )),
    ),
  );
}
