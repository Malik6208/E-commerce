import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_fusion/controllres/get_device_token_controller.dart';
import 'package:shop_fusion/models/user_model.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';

class SigningGoogleController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    GetDeviceController tokenController=Get.put(GetDeviceController());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }
        EasyLoading.show(status: 'Please Wait...');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Store user data in Firebase or locally
      if (user != null) {
        await storeUserData(user,tokenController);
      }

      return user;
    } catch (e) {
      EasyLoading.dismiss();
      print('Error signing in with Google: $e');
      return null;
    }
  }
  Future<void> storeUserData(User user,GetDeviceController controller) async {
    // Store user data in Firestore, SharedPreferences, or another storage option
    // Example: Save in Firestore
    UserModel userModel=UserModel(
      uId: user.uid,
      userName: user.displayName.toString(),
      email: user.email.toString(),
      phone: user.phoneNumber.toString(),
      userImg: user.photoURL.toString(),
      userDeviceToken:controller.deviceToken.toString(),
      country: '',
      userAddress: '',
      street: '',
      isAdmin: false,
      isActive: true,
      createdOn: DateTime.now().toString(),
    );
    await FirebaseFirestore.instance.collection('users').
    doc(user.uid).set(userModel.toJson());
    EasyLoading.dismiss();
    Get.offAll(()=>MainScreen());
  }
}