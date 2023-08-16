
import 'dart:io'; // for File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytaxi/controller/auth_controller.dart';
import 'package:easytaxi/utils/app_color.dart';
import 'package:easytaxi/views/homescreen.dart';
import 'package:easytaxi/widgets/profilesettingtextfield_wdget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../widgets/bluebutton_widget.dart';
import '../widgets/profilesetting_widget.dart';
import 'package:path/path.dart' as Path;

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {

  AuthController authcontroller = Get.find<AuthController>();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();

  
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(

              child: Stack(
                children: [
                  yellowIntroWidgetWithoutLogo(),

                  Align(
                   alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        getImage(ImageSource.camera);
                      },
                      child: selectedImage == null ? Container(
                        child:  Center(
                            child: Icon(Icons.camera_alt_outlined,
                            size: 50,
                            color: AppColors.whiteColor,
                            ),
                        ),
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(top: 190),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.yellowColor,
                        ),
                      ):Container(
                       
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(top: 190),
                        decoration: BoxDecoration(
                          
                          image: DecorationImage(
                            image: FileImage(selectedImage!),
                            fit: BoxFit.fill,
                            ),
                          shape: BoxShape.circle,
                          color: AppColors.yellowColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Container( 
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget('Name', Icons.person_outline_outlined, nameController,(String? input){
              
                        if(input!.isEmpty){
                          return 'Name is required';
                        }
                        if(input.length < 5){
                          return 'please enter a valid name';
              
                        }
                        return null;
                    }),
                    SizedBox(height:10),
              
                    TextFieldWidget('Home Addresss', Icons.home_outlined, homeController,(String? input){
                        if(input!.isEmpty){
                          return 'Home address is required';
                        }
                        return null;
                    }),
                    SizedBox(height:10),
              
                    TextFieldWidget('Business Address', Icons.card_travel, businessController,(String? input){
                        if(input!.isEmpty){
                          return 'business address is required';
                        }
                        return null;
                    }),
                    SizedBox(height:10),
              
                    TextFieldWidget('Shopping Center', Icons.shopping_cart_outlined, shopController,(String? input){
                        
                        if(input!.isEmpty){
                          return 'shoppping center is required';
                        }
                        
                        return null;
                    }),
                    SizedBox(height:30),
              
                    Obx(() => authcontroller.isProfileUploading.value ? 
                    Center(child: CircularProgressIndicator(),
                    )
                    :darkBlueButtn('Submit',(){

                      if(!formKey.currentState!.validate()){
                        return;

                      }
                    
                    if(selectedImage == null){
                      Get.snackbar('Warning','Please add your Image');
                      return;
                    }
                    authcontroller.isProfileUploading(true);
                    authcontroller.storeUserInfo(selectedImage!,nameController.text,homeController.text,businessController.text,shopController.text);
                    }),
                    
                    ),
                  ],
              
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
