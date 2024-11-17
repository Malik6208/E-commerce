import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomTextfield extends StatelessWidget {
  String hint;
      TextEditingController controller;
  TextInputType type;
      IconData piconData;
   CustomTextfield({
     super.key,
     required this.hint,
     required this.controller,
     required this.piconData,
     required this.type,
   });

  @override
  Widget build(BuildContext context) {
  final  mq=MediaQuery.of(context).size;
    return Container(
      height: Get.height*.068,
      width:mq.width*1 ,
       margin: EdgeInsets.only(top: mq.height*.024,left: Get.width*.03,right:Get.width*.03  ),
      child:TextFormField(
        maxLines: 4,
        obscureText:false ,
        controller: controller,
        keyboardType:type ,
        validator: (value)
        {
          if(value==null || value.isEmpty)
          {
            return 'please enter valid data';
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(piconData,size: 34,),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 21),
            labelText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18)
            )

        ),
      )
    );
  }
}
