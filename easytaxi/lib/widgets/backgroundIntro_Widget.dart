import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget backgroundIntro(){
  return Container(
    width: Get.width,
    height: Get.height*0.64,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image:  AssetImage("assets/background2.png"),
          fit: BoxFit.cover,
      ),
    ),

    child: Column(
      children:[
        SizedBox(height: 70,),
        Image.asset('assets/back_car.png',width: 300,height: 290,),
        Image.asset('assets/yellow_taxi.png',width: 200,height: 140,),
      ],
    ),



  );
}
