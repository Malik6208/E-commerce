import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/screens/admin_panel/admin_main_screen.dart';
import 'package:shop_fusion/screens/auth_ui/sign_in_screen.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';
import 'package:shop_fusion/utils/app_constant.dart';

import '../utils/utils.dart';
import 'firebase/get_user_data_controller.dart';

class SignInController extends GetxController{
 final GetUserDataController getUserDataController=Get.put(GetUserDataController());
  final FirebaseAuth _auth=FirebaseAuth.instance;

  signIn(String email,String password)async{
    if(email==''||password=='')
      {
       Get.snackbar('error', 'Please Enter Valid details',
         snackPosition: SnackPosition.BOTTOM,

       ) ;
      }else{
      try{
        EasyLoading.show(status: 'Please Wait...');
    UserCredential? credential=   await _auth.signInWithEmailAndPassword(email: email, password: password);
         var userData= await getUserDataController.getUserData(credential.user!.uid);
         EasyLoading.dismiss();
          if(credential!=null)
            {
              if(userData[0]['isAdmin']==true)
                {
                Get.offAll(AdminMainScreen());
                Get.snackbar('Admin login',
                    'Login successfully',
                    backgroundColor: Colors.grey,
                  colorText: Colors.white
                );
                }else{
                Get.offAll(MainScreen());
                Get.snackbar('Admin login',
                    'Login successfully',
                    backgroundColor: Colors.grey,
                    colorText: Colors.white
                );
              }
            }

      } on FirebaseAuthException catch(e){
        EasyLoading.dismiss();
        Get.snackbar('Error', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appMainColor,
          colorText: Colors.green,
        );

      }
    }
  }

  resetPassword(String email, BuildContext context) async {
       if(email=='')
         {
           Utils.myFlushBar('Email Required', context);
         }else{
         try{
           EasyLoading.show(status: 'Please Wait');
          await _auth.sendPasswordResetEmail(email: email);

           Utils.myFlushBar('Password Reset link Sent Your Email', context);
           EasyLoading.dismiss();
         } on FirebaseAuthException catch(e){
           EasyLoading.dismiss();
           Utils.myFlushBar(e.toString(), context);
         }
       }
  }
}
