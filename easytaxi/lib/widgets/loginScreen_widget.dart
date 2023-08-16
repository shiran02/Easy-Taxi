import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';
import '../utils/app_constants.dart';
import '../views/otpverificationscreen.dart';
import 'text_widget.dart';

Widget LoginScreenWidget(CountryCode countryCode , Function onCountryChanged , Function onSubmit){
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
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.yellowColor.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 12,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap:() => onCountryChanged(),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 3,
                        ),

                        Expanded(
                            child: Container(
                              child: countryCode.flagImage,
                            )
                        ),

                        const SizedBox(
                          width: 1,
                        ),

                        textWidget(
                            text: countryCode.dialCode,
                            textAlign: TextAlign.start,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor
                        ),
                        //


                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),


                Container(
                  width: 4,
                  height: 65,
                  decoration: BoxDecoration(
                    color: AppColors.yellowColor.withOpacity(0.2),
                  ),
                ),


                Expanded(
                  flex: 3,
                  child: Container(
                  //  margin: EdgeInsets.only(left: 15),
                    child: TextField(
                      keyboardType: TextInputType.phone,

                      onSubmitted: (String? input) => onSubmit(input),

                     // onSubmitted: (String? input) => onSubmit(input),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppConstants.enterMobileNumber,
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14, color: AppColors.blackColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                          text: AppConstants.byCreating + ' ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          )),
                      TextSpan(
                          text: AppConstants.termsOfServices + ' ',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                          )),
                      TextSpan(
                          text: AppConstants.privacyPolicy,
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold)),
                    ])),
          ),
        ],
      ),
  );
}