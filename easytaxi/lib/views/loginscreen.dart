import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/backgroundIntro_Widget.dart';
import '../widgets/loginScreen_widget.dart';
import 'otpverificationscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  

    ////default country code...
  final countryPicker = const FlCountryCodePicker();

  CountryCode countryCode =
      const CountryCode(name: "Sri Lanka", code: "LK", dialCode: "+94");

  onSubmit(String? input){
    Get.to(() => OtpverificationScreen(countryCode.dialCode + input!));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ////// background part.......................................................
              backgroundIntro(),
              ////// login part ...........................................................
              LoginScreenWidget(
                countryCode,
                () async {
                  final code = await countryPicker.showPicker(context: context);
                  if (code != null) countryCode = code;
                  setState(() {});
                },
                  onSubmit
              ),
            ],
          ),
        ),
      ),
    );
  }
}