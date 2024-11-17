


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_fusion/controllres/firebase/get_user_data_controller.dart';
import 'package:shop_fusion/screens/admin_panel/admin_main_screen.dart';
import 'package:shop_fusion/screens/auth_ui/welcome_screen.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';

import '../../utils/app_constant.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  User? user=FirebaseAuth.instance.currentUser;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      loggedin(context);
    } );
  }
  Future<void> loggedin(BuildContext context)async{
   if(user==null)
     {
      Get.offAll(WelcomeScreen());
     }else{
     final GetUserDataController _controller=Get.put(GetUserDataController());
     var userData=await _controller.getUserData(user!.uid);
     if(userData[0]['isAdmin']==true)
       {
         Get.offAll(AdminMainScreen());
       }else{
       Get.offAll(MainScreen());
     }
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondryColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Lottie.asset('assets/animation/animat.json')
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(AppConstant.appPaweredBy,style:
              TextStyle(color: AppConstant.appTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 24
              )
              ),
            )
          ],
        ),
      ),
    );
  }
}
