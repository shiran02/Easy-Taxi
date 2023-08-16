import 'package:easytaxi/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget yellowIntroWidgetWithoutLogo() {
  return Container(
    width: Get.width,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pofilesetting_backgroundintro.png'),
            fit: BoxFit.fill)),
    height: Get.height * 0.3,
    child: Container(
      height: Get.height * 0.1,
      width: Get.width,
      margin: EdgeInsets.only(bottom: Get.height * 0.05),
      child: Center(
        child: Text(
          'Profile Setting',
          style: GoogleFonts.poppins(
              fontSize: 24,
              color: AppColors.yellowColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}


