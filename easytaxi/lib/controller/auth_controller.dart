import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/homescreen.dart';
import '../views/profilesettingscreen.dart';
import 'package:path/path.dart' as Path;

class AuthController extends GetxController{
  String userId = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credential;

  var isProfileUploading = false.obs;

  phoneAuth(String phone) async {

    try{
      credential = null;

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Completed');
          //print('Completed');
          credential = credential;
          await FirebaseAuth.instance
              .signInWithCredential(credential);

        },

        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          print('failed');
          if(e.code == "Invalid phone number"){
            debugPrint("The provide phone number is not valid");
          }
        },


        codeSent: (String verificationId, int? resendToken) async{
          print('code send');
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }catch(e){
      print(e);
    }

  }

  verifyOtp(String otpNumber) async {
    print("called 56");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otpNumber);
    log("loged in 61");

    await FirebaseAuth.instance
        .signInWithCredential(credential).then((value){
      decideRoute();
    });

  }


  decideRoute(){
    ///step 1-Check userr login ?
    ///

    User? user = FirebaseAuth.instance.currentUser;


    //user already login ----

    if(user != null){
      ///step 2 - check another user profile exists?

      FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          .then((value){
        if(value.exists){
          Get.to(() => HomeScreen());
          //Get.to(() => ProfileSettimgScreen());
        }else{
          Get.to(() => ProfileSettingScreen());
        }
      });

    }

  }




  uploadImage(File image)async{
      String imageUrl ='';
      String fileName = Path.basename(image.path);
      var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName');   ///Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then((value){
      imageUrl = value;
      print("Dawnload URL : $value");
    });
      return imageUrl;
  }


  storeUserInfo(File selectedImage,String name ,String home,String businuss,String shop) async{

    String url = await uploadImage(selectedImage);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image':url,
      'name':name,
      'home_address':home,
      'business_address':businuss,
      'shipping_address':shop,
    }).then((value){
      
      isProfileUploading(false);
      Get.to(()=>HomeScreen());
    });
  }
}