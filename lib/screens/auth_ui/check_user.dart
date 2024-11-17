import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_fusion/screens/auth_ui/welcome_screen.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';
class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return CheackUser();
  }

   CheackUser() {
   final _auth=FirebaseAuth.instance.currentUser;
   if(_auth==null)
     {
       return const WelcomeScreen();
     }else{
     return const MainScreen();
   }

   }
}
