import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controller/auth_controller.dart';
import '../utils/app_color.dart';

class PinputWidget extends StatefulWidget {
  const PinputWidget({Key? key}) : super(key: key);

  @override
  State<PinputWidget> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    const focusedBorderColor = Color.fromRGBO(239, 128, 0, 1.0);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.amber;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        // color: Color.fromRGBO(30, 60, 87, 1),
        color: AppColors.yellowColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: pinController,
              focusNode: focusNode,
              onCompleted: (String input){
                authController.verifyOtp(input);
              },
              androidSmsAutofillMethod:
              AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              // validator: (value) {
              //   return value == '2222' ? null : 'Pin is incorrect';
              // },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              //           hapticFeedbackType: HapticFeedbackType.lightImpact,
              // onCompleted: (pin) {
              //   debugPrint('onCompleted: $pin');
              // },
              // onChanged: (value) {
              //   debugPrint('onChanged: $value');
              // },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          TextButton(
            onPressed: () => formKey.currentState!.validate(),
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}