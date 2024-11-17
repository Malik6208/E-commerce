import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shop_fusion/controllres/get_device_token_controller.dart';

class BannerControllers extends GetDeviceController{
  RxList<String> bannerUrls=RxList<String>([]);
  RxList<String> nuf=RxList([]);
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    featchBanners();
  }

  Future<void> featchBanners() async{
    try{
      QuerySnapshot<Map<String, dynamic>> bannerSnapShot=await _firestore.collection('banners').get();
      if(bannerSnapShot.docs.isNotEmpty)
        {
          bannerUrls.value=bannerSnapShot.docs.map((e)=>e['imageUrls'] as String).toList();
        }
    } catch(e){
      if (kDebugMode) {
        print('data not fetches');
      }
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}