
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllres/sign_up_controller.dart';
import 'package:shop_fusion/screens/auth_ui/sign_in_screen.dart';

import '../../utils/app_constant.dart';
import '../../utils/compenents/custom_button.dart';
import '../../utils/compenents/custom_textField.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  ValueNotifier<bool> notifier=ValueNotifier(false);
  SignupController controller=Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    final mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('SignupScreen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text('Welcom to my app',style: TextStyle(
                      fontSize: 30,
                      fontWeight:FontWeight.bold,
                      color: AppConstant.appSecondryColor
                    ),),
                  ),
                ),
            SizedBox(height: 40,),
            CustomTextfield(
                hint: 'Enter Name',
                controller: nameController,
                piconData: Icons.person,
                type: TextInputType.name
            ),
            CustomTextfield(
                hint: 'Enter Email',
                controller: emailController,
                piconData: Icons.email,
                type: TextInputType.emailAddress
            ),
            CustomTextfield(
                hint: 'Enter phone',
                controller: phoneController,
                piconData: Icons.phone,
                type: TextInputType.number
            ),
            CustomTextfield(
                hint: 'Enter city',
                controller: cityController,
                piconData: Icons.phone,
                type: TextInputType.name
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
            SizedBox(height: 47,),
            CustomButtom(voidCallback: (){
              controller.signUpWithEmail(context,
                  nameController.text.trim(),
                  emailController.text.trim(),
                  phoneController.text.trim(),
                  cityController.text.trim(),
                  passController.text.trim(),
                  ''
              );
            },
                title: 'Signup Up'),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 2, 0),
              child: Row(
                children: [
                  SizedBox(width: 40,),
                  Text("I have already an account ",style: TextStyle(fontSize: 18),),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                      },
                      child: Text(
                        'Sign In'
                        ,style: TextStyle(fontSize: 21,color: AppConstant.appSecondryColor),
                      )
                  ),
        
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
