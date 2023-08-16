import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

TextFieldWidget(String title, IconData icondata,
    TextEditingController controller,Function validator) {


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkBluEcolor,
        ),
      ),
      const SizedBox(
        height: 6,
      ),

      Container(
        width: Get.width,
        //height: 50,

        decoration: BoxDecoration(
          color: AppColors.yellowColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1),
          ],
          borderRadius: BorderRadius.circular(8),
        ),


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            
            // validator: (String? input){
            //   validator(input);
            // },
            validator: (input)=>validator(input),
            
            controller: controller,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBluEcolor,
            ),
            decoration: InputDecoration(
              hintText: 'Enter '+title,
              hintStyle: TextStyle(color:Colors.grey[540]),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  icondata,
                  color: AppColors.darkBluEcolor,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),


      ),
    ],
  );
}