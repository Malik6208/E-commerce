import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class GetDeviceController extends GetxController{
  String? deviceToken;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceToken();
  }
  Future<void> getDeviceToken()async{
    try{
      String? token=await FirebaseMessaging.instance.getToken();
      if(token!=null)
        {
          deviceToken=token;
          update();
          print(deviceToken);
        }
    } on FirebaseAuthException catch(e) {
     Get.snackbar('error', e.toString(),
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.grey,
       colorText: Colors.white,

     );
    }
  }
}