import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartTotalPriceController extends GetxController{
  RxDouble totalPrice=0.0.obs;
  User? user=FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProductsPrice();
  }

  Future<void> fetchProductsPrice() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot=await FirebaseFirestore.instance.
    collection('Carts').doc(user!.uid).collection('cartOrders').get();
    double sum=0.0;
    for(var doc in snapshot.docs)
      {
        final data=doc.data();
        if(data!=null)
          {
            sum+=(data['productFullPrice']).toDouble();
          }

      }
    totalPrice.value=sum;
  }
}