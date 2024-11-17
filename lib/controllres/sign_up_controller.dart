import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/models/user_model.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';
import 'package:shop_fusion/utils/app_constant.dart';

import '../utils/utils.dart';
import 'get_device_token_controller.dart';

class SignupController extends GetxController{
final FirebaseAuth _auth =FirebaseAuth.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<User?> signUpWithEmail(
    BuildContext context,
    String userName,
    String email,
    String userPhone,
    String userCity,
    String userPassword,
    String userDeviceToken
    )async{
  GetDeviceController tokenController=Get.
  put(GetDeviceController());


  if(userName==''||email==''||userCity==''||userPhone==''||userPassword=='')
        {
          Utils.myFlushBar('Please Enter Valid Details', context);
        }else if(userPassword.length<=6)
        {
          Get.snackbar('Error', 'Password must be grater than 6 Character',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppConstant.appMainColor,
              colorText: AppConstant.appTextColor,
              duration: Duration(seconds: 2)
          );
        }else{
          try{
            EasyLoading.show(status: 'Please Wait...');
          UserCredential credential=await _auth.createUserWithEmailAndPassword(
              email: email, password: userPassword);
          final User? user=credential!.user;
          //String img=uploadImage();
          if(user!=null)
            {
              UserModel userModel=UserModel(
                userName: userName,
                email: email,
                phone: userPhone,
                city: userCity,
                userDeviceToken: tokenController.deviceToken.toString(),
                country: '',
                userAddress: '',
                street: '',
                uId: user.uid,
                userImg: '',
                isAdmin: false,
                isActive: true,
                createdOn: DateTime.now().toString()
              );
              _firestore.collection('users').doc(user.uid).set(userModel.toJson());
              EasyLoading.dismiss();
              Get.offAll(MainScreen());
            }

        }
          on FirebaseAuthException catch(e){
            EasyLoading.dismiss();
            Utils.myFlushBar(e.toString(), context);
          }
      }
}

}