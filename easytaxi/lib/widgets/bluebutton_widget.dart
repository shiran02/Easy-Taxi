import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

darkBlueButtn(String title, Function onPressed) {
  return MaterialButton(
    minWidth: Get.width,
    height: 50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: AppColors.darkBluEcolor,
    onPressed: () => onPressed(),
    child: Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.yellowColor),
    ),
  );
}