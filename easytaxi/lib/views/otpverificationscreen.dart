import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../utils/app_color.dart';
import '../widgets/backgroundIntro_Widget.dart';
import '../widgets/otpverification_widget.dart';

class OtpverificationScreen extends StatefulWidget {

 // const OtpverificationScreen(String s, {Key? key}) : super(key: key);

 String phoneNumber;
  OtpverificationScreen(this.phoneNumber);

  @override
  State<OtpverificationScreen> createState() => _OtpverificationScreenState();
}

class _OtpverificationScreenState extends State<OtpverificationScreen> {

 AuthController authcontroller = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authcontroller.phoneAuth(widget.phoneNumber);
  }



  @override
  Widget build(BuildContext context) {
   AuthController authcontroller = Get.put(AuthController());
    authcontroller.decideRoute();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Stack(
                children: [
                  backgroundIntro(),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: InkWell(
                      onTap: (){
                        Get.back();
                      },

                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.yellowColor.withOpacity(1),

                        ),

                        child: const Icon(Icons.arrow_back , color: AppColors.blackColor,),
                      ),
                    ),
                  ),
                ],
              ),

              otpVerificationWidget(),

            ],
          ),


        ),
      ),
    );
  }
}