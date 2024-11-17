
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_fusion/controllres/sign_in_controller.dart';
import 'package:shop_fusion/screens/auth_ui/reset_password_screen.dart';

import '../../utils/app_constant.dart';
import '../../utils/compenents/custom_button.dart';
import '../../utils/compenents/custom_textField.dart';
import 'signup_screen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController controller=Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> notifier=ValueNotifier(false);
    var emailController=TextEditingController();
    var passController=TextEditingController();
    final mq=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height:mq.height*.48 ,
                child: Lottie.asset('assets/animation/ecomAnimat.json'),
                color: AppConstant.appSecondryColor,
              ),
             Column(
               children: [
                 SizedBox(height: mq.height*.06,),
                 CustomTextfield(
                   hint: 'Email',
                   controller: emailController,
                   piconData: Icons.email,
                   type: TextInputType.emailAddress,
                 ),
                 Container(
                  // height: mq.height*.1,
                   width:mq.width*.91,
                   margin: EdgeInsets.only(top: 20),
                   child: ValueListenableBuilder(
                     valueListenable: notifier,
                     builder: (context, value, child) {
                       return  TextFormField(
                         validator: (value){
                           if(value==null || value.isEmpty)
                           {
                             return 'Please enter password';
                           }
                           return null;
                         },
                         obscureText: notifier.value,
                         controller: passController,
                         decoration: InputDecoration(
                             prefixIcon: const Icon(Icons.lock,size: 34,),
                             suffixIcon: InkWell(
                               onTap: (){
                                 notifier.value=!notifier.value!;
                               },
                               child:  Icon(
                                   notifier.value? Icons.visibility_off_outlined
                                       :Icons.visibility
                               ),
                             ),
                             hintText: 'Password',
                             hintStyle: TextStyle(fontSize: 21),
                             labelText: "Password",
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10)
                             )

                         ),
                       );
                     },

                   ),
                 ),
                 Align(
                   alignment: Alignment.centerRight,
                   child: TextButton(
                       onPressed: (){

                         Get.to(const ResetPasswordScreen());

                       }, child: const Text('Forget Password',style: TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.bold
                   ),)),
                 ),
                const SizedBox(height: 20,),
                 CustomButtom(
                     voidCallback: (){
                       controller.signIn(
                           emailController.text.trim(),
                           passController.text.trim(),
                       );
                     },
                     title: 'Sign In'),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(10, 20, 2, 0),
                   child: Row(
                     children: [
                       SizedBox(width: 40,),
                       Text("Don't have an account? ",style: TextStyle(fontSize: 18),),
                       InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                           },
                           child: Text(
                             'Sign up'
                             ,style: TextStyle(fontSize: 21,color: AppConstant.appSecondryColor),
                           )
                       ),

                     ],
                   ),
                 )
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
