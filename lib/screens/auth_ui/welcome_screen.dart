import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_fusion/controllres/signing_with_google.dart';
import 'package:shop_fusion/screens/auth_ui/sign_in_screen.dart';
import '../../utils/app_constant.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  SigningGoogleController controller=Get.put(SigningGoogleController());
  @override
  Widget build(BuildContext context) {
    final mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
        backgroundColor:AppConstant.appSecondryColor ,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: AppConstant.appSecondryColor,
                child: Lottie.asset('assets/animation/animat.json'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                    'Happy Shoping',
                  style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mq.height*.14),
                width: mq.width*.8,
                height: mq.height*.08,
                decoration: BoxDecoration(
                  color: AppConstant.appSecondryColor,
                  borderRadius: BorderRadius.circular(18)
                ),
                child: TextButton.icon(
                    onPressed: (){
                      controller.signInWithGoogle();
                    },
                    label: Text('Sign in with Google',style: TextStyle(
                      color: AppConstant.appTextColor,
                      fontSize: 19
                    ),),
                  icon: Image.asset('assets/icons/gogle.png'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mq.height*.04),
                width: mq.width*.8,
                height: mq.height*.08,
                decoration: BoxDecoration(
                    color: AppConstant.appSecondryColor,
                    borderRadius: BorderRadius.circular(18)
                ),
                child: TextButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                    },
                    label: Text('Sign in with Email',style: TextStyle(
                        color: AppConstant.appTextColor,
                        fontSize: 19
                    ),
                    ),
                 icon: Icon(Icons.email,size: 50,color: AppConstant.appTextColor,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
