import 'package:easytaxi/views/homescreen.dart';
import 'package:easytaxi/views/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';
import 'firebase_options.dart';
import 'views/profilesettingscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



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
      
      //home: LoginScreen(),
      home: AppRoot(),
      //home: ProfileSettingScreen(),

    );
  }
}

class AppRoot extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            // User is not authenticated, show phone number verification screen.
            return LoginScreen();
          } else {
            // User is authenticated, navigate to home screen.
            return HomeScreen();
          }
        }
        // Handle other connection states here.
        return CircularProgressIndicator();
      },
    );
  }
}