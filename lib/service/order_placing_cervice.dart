import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/models/order_model.dart';
import 'package:shop_fusion/models/user_model.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'package:uuid/uuid.dart';

import '../controllres/firebase/farebase_hepler.dart';
import '../utils/utils.dart';

class OrderPlacingCervice extends GetxController{
  UserModel? userModel;
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
   await fetchUserProfilePic();
    if (name != '' && phone != '' && address != '' && pinCode != '' &&
        deviceToken != '') {
      EasyLoading.show(status: 'Please Wait...');
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
                 OrdersModel ordersModel=OrdersModel(
                     createdAt: DateTime.now().toString(),
                     deliveryTime: data['deliveryTime'],
                     fullPrice: data['fullPrice'],
                     isSale: data['isSale'],
                     productDescription: data['productDescription'],
                     productId: data['productId'],
                     productImages:data ['productImages'],
                     productName: data['productName'],
                     salePrice: data['salePrice'],
                     productQuantity: data['productQuantity'],
                     productFullPrice: double.parse(data['productFullPrice'].toString()),
                     status: false,
                     customerName: name,
                     customerImg: userModel!.userImg.toString(),
                     customerPhone: phone,
                     customerAddress:address,
                     customerPinCode: pinCode,
                     customerDeviceToken: deviceToken,
                     customerId:user!.uid,
                   ordersId:id ,
                 );
                 for(var x=0;x<documents.length;x++)
                   {
                     //uploads orders data
                     await FirebaseFirestore.instance.collection('orders').
                     doc(user!.uid).collection('confirmOrders').
                     doc(id).set(ordersModel.toJson());
                     // delete cartOrders
                     await FirebaseFirestore.instance.collection('Carts')
                         .doc(user!.uid).collection('cartOrders').
                     doc(ordersModel.productId.toString()).delete();
                   }

              }
            Get.snackbar('Order Confirmed',
              'Thank u for your order',
              backgroundColor: AppConstant.appSecondryColor,
              colorText: Colors.white,
              duration:const Duration(seconds: 3),
            );
            EasyLoading.dismiss();
            Get.offAll(const MainScreen());
          }catch(e){

          }
        }



    }else{
      Utils.showToast('Please Enter valid Details');
    }
  }
  Future<void> fetchUserProfilePic() async {
    userModel=await FireBaseHelper.fetchUserProfilePic();

  }
}