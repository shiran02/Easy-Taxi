import 'dart:async';

import 'package:easytaxi/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _mapStyle;
  TextEditingController controller = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBluEcolor,
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              zoomControlsEnabled: false,
              //mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                myMapController = controller;
                myMapController!.setMapStyle(_mapStyle);
              },
            ),
          ),
          buildProfileTitle(),
          // placesAutoCompleteTextField(),
          buildTextField(),

          buildTextFieldForSource(),

          showSourceField ? buildCurrentLocationIcon() : Container(),

          buildNotificationIcon(),

          buildBottomSheet(),
        ],
      ),
    );
  }

  Widget buildProfileTitle() {
    return Positioned(
        top: 30,
        left: 0,
        right: 0,
        child: Container(
          width: Get.width,
          height: Get.height * 0.14,
          decoration: BoxDecoration(
            color: AppColors.yellowColor.withOpacity(0.3),
            //borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.fill)),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Good Morning, ',
                          style: TextStyle(
                              color: AppColors.yellowColor, fontSize: 14)),
                      TextSpan(
                          text: 'Shiran',
                          style: TextStyle(
                              color: AppColors.yellowColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  const Text(
                    "Where are you going?",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowColor),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  bool showSourceField = false;

  Widget buildTextField() {
    return Positioned(
      top: 158,
      left: 18,
      right: 18,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.yellowColor.withOpacity(1),
          boxShadow: [
            BoxShadow(
              color: AppColors.yellowColor.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          // controller:  destinationController,
          autofocus: true,
          readOnly: true,
          onTap: () async {
            controller:
            destinationController;
            //showGoogleAutoComplete();
            String selectedPlace = await showGoogleAutoComplete();

            destinationController.text = selectedPlace;

            setState(() {
              showSourceField = true;
            });
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          decoration: const InputDecoration(
            hintText: 'Search for adestination',
            //  hintStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 1),
              child: Icon(Icons.search, color: Colors.black),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldForSource() {
    return Positioned(
      top: 218,
      left: 18,
      right: 18,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.yellowColor.withOpacity(1),
          boxShadow: [
            BoxShadow(
              color: AppColors.yellowColor.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: sourceController,
          autofocus: true,
          readOnly: true,
          onTap: () async {
            Get.bottomSheet(Container(
              width: Get.width,
              height: Get.height * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: AppColors.yellowColor),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      SizedBox(
                        height: 20,
                      ),
                      
                      Text("Select Your Location ",style: TextStyle(color: AppColors.blackColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      
                      SizedBox(
                        height: 10,
                      ),

                      Text("Home Address ",style: TextStyle(color: AppColors.blackColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      
                      Container(
                        width: Get.width,
                        height: 50,
                        decoration: BoxDecoration(
                          
                          boxShadow: [
                                BoxShadow(
                                  color: AppColors.blackColor.withOpacity(0.02),
                                  spreadRadius: 4,
                                  blurRadius: 10
                                )
                          ]
                        ),

                        child:Text("Kurunagala",style: TextStyle(color: AppColors.blackColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      
                      )
                    ],
                  ),
            ));
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          decoration: const InputDecoration(
            hintText: 'From:',
            //  hintStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 1),
              child: Icon(Icons.search, color: Colors.black),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildCurrentLocationIcon() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 18, right: 10),
        child: CircleAvatar(
          radius: 27,
          backgroundColor: AppColors.yellowColor,
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget buildNotificationIcon() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 78, right: 10),
        child: CircleAvatar(
          radius: 27,
          backgroundColor: AppColors.yellowColor,
          child: Icon(Icons.notifications),
        ),
      ),
    );
  }

  Widget buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width * 0.8,
        height: 17,
        decoration: BoxDecoration(
            color: AppColors.yellowColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Center(
          child: Container(
            width: Get.width * 0.6,
            height: 4,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }

  Future<String> showGoogleAutoComplete() async {
    const kGoogleApiKey = "AIzaSyAdiSlg_ED6_M97F8FoM3VLQG282vSzQGE";

    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 10000000,
      strictbounds: false,
      region: "us",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      components: [
        Component(Component.country, "sl"),
        Component(Component.country, "in"),
        Component(Component.country, "UK")
      ],
      types: ["(cities)"],
      hint: "Search City",
    );

    return p!.description!;
  }
}
