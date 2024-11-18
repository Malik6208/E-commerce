import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../utils/utils.dart';

class OrderPlacingCervice extends GetxController{
  User? user=FirebaseAuth.instance.currentUser;
  var uuid = const Uuid();
  placeOrder({
    required BuildContext context,
    required String name,
    required String phone,
    required String address,
    required String pinCode,
    required String deviceToken,
  }) async {
    if (name != '' && phone != '' && address != '' && pinCode != '' &&
        deviceToken != '') {
      if(user!=null)
        {
          try{
            QuerySnapshot querySnapshot=await FirebaseFirestore.instance.
            collection('Carts').doc(user!.uid).collection('cartOrders').get();
            List<QueryDocumentSnapshot> documents=querySnapshot.docs;
            for(var doc in documents)
              {
                Map<String,dynamic> data=doc.data() as Map<String,dynamic>;
                 String id=uuid.v4();

              }
          }catch(e){

          }
        }



    }else{
      Utils.showToast('Please Enter valid Details');
    }
  }
}