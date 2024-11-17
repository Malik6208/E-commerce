import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'package:shop_fusion/utils/compenents/custom_button.dart';

import '../../controllres/firebase/cart_total_price_controller.dart';
import '../../utils/compenents/custom_textField.dart';
class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CartTotalPriceController cartTotalPriceController=Get.put(CartTotalPriceController());
  final fireStore= FirebaseFirestore.instance.collection('Carts').
  doc(FireBaseHelper.user!.uid).collection('cartOrders');
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('CheckOutScreen'),
      ),
      body: StreamBuilder(
        stream: FireBaseHelper.fetchOrderCarts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cartOders found.'));
          } else {
            cartTotalPriceController.fetchProductsPrice();
            List<CartModel> cartModels = snapshot.data!;
            return ListView.builder(
              itemCount: cartModels.length,
              itemBuilder: (context, index) {
                CartModel cartModel=cartModels[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: Get.height / 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13)
                  ),
                  child:SwipeActionCell(
                    key: ObjectKey(cartModel.productId), /// this key is necessary
                    trailingActions: <SwipeAction>[
                      SwipeAction(
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          title: "delete",
                          onTap: (CompletionHandler handler) async {
                            FirebaseFirestore.instance.collection('Carts').
                            doc(FireBaseHelper.user!.uid).collection('cartOrders').
                            doc(cartModel.productId).delete();
                            print('data deleted ${cartModel.productId}');
                          },
                          color: Colors.red),
                    ],
                    child:Card(
                      elevation: 2,
                      child: ListTile(
                        leading:  CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.green,
                          backgroundImage:CachedNetworkImageProvider(cartModel.productImages) ,
                        ),
                        title:  Text(cartModel.productName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(cartModel.productFullPrice.toString()),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },),
      bottomNavigationBar: Container(
        margin:const EdgeInsets.symmetric(horizontal: 12),
        height: Get.height/15,
        child: Row(
          children: [
            const Text('Total',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
            SizedBox(width: Get.width/20,),
            Obx(() => Text(cartTotalPriceController.totalPrice.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), )
              ,),
            Spacer(),
            SizedBox(
              width: Get.width*.45,
              child: ElevatedButton(onPressed: (){
                buttomSheet();
              },
                  style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appSecondryColor),
                  child: const Text('Confirm Order',style: TextStyle(fontSize: 19,color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
    buttomSheet(){
     Get.bottomSheet(
       backgroundColor: Colors.transparent,
     Container(
       height: Get.height*.8,
       decoration:const BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.vertical(
             top: Radius.circular(14)),
       ),
       child: SingleChildScrollView(
         child: Column(children: [
           CustomTextfield(hint: 'Name',
               controller: nameController,
               piconData: Icons.person,
               type: TextInputType.name,
           ),
           CustomTextfield(hint: 'Phone',
             controller: phoneController,
             piconData: Icons.phone,
             type: TextInputType.phone,
           ),
           CustomTextfield(hint: 'Address',
             controller: addressController,
             piconData: Icons.location_on_rounded,
             type: TextInputType.name,
           ),
           CustomTextfield(hint: 'Pin Code',
             controller: pinCodeController,
             piconData: Icons.location_searching,
             type: TextInputType.name,
           ),
           SizedBox(height: Get.height*.04,),
           CustomButtom(voidCallback: (){
             if (kDebugMode) {
               print('Fucket');
             }
           },
               title: 'Place Order'),
         ],),
       ),
     ),

     );
    }
}
