import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllres/sign_in_controller.dart';
import 'package:shop_fusion/utils/compenents/custom_button.dart';
import 'package:shop_fusion/utils/compenents/custom_textField.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController=TextEditingController();
  SignInController controller=Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
                hint: 'Please Enter Email',
                controller: emailController,
                piconData: Icons.email,
                type: TextInputType.emailAddress
            ),
           const SizedBox(height: 20,),
            CustomButtom(voidCallback: () {
             controller.resetPassword(emailController.text.trim(), context);
            }, title: 'Reset Password')
          ],
        ),
      ),
    );
  }
}
