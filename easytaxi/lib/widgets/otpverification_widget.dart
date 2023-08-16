import 'package:easytaxi/widgets/pinput_widget.dart';
import 'package:easytaxi/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';
import '../utils/app_constants.dart';

Widget otpVerificationWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 40,
          ),

          textWidget(
              text: AppConstants.helloNiceToMeetYou,
              color: AppColors.blackColor,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              textAlign: TextAlign.start),
          textWidget(
              text: AppConstants.getMovingWithGreeenTaxi,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 21,
              textAlign: TextAlign.start),

          SizedBox(
            height: 10,
          ),

          Container(
              width: Get.width,
              child: const PinputWidget()
          ),

          SizedBox(
            height: 30,
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.normal),
                    children: const [
                      TextSpan(
                          text: AppConstants.resendCode + ' ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          )),
                      TextSpan(
                          text: 'in 10 second',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold)),

                    ])),
          ),
        ],
      ),
  );
}