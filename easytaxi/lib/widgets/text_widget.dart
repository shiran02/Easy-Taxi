import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required TextAlign textAlign
    }) {
  return Text(
    text,
   // style: TextStyle(fontSize: fontSize,fontWeight: fontWeight, color: color),
    style: GoogleFonts.poppins(fontSize: fontSize,fontWeight: fontWeight,color: color),
  );
}