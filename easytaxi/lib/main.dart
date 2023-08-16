import 'package:easytaxi/views/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';
import 'firebase_options.dart';
import 'views/profilesettingscreen.dart';




void main() async{

 WidgetsFlutterBinding.ensureInitialized();

 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  
  

  @override
  Widget build(BuildContext context) {

    

   

    AuthController authcontroller = Get.put(AuthController());
    authcontroller.decideRoute();
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      ////////// Login Screen................................
      
      home: LoginScreen(),
      //home: ProfileSettingScreen(),

    );
  }
}