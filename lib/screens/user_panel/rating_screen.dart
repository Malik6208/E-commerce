import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_fusion/models/order_model.dart';
import 'package:shop_fusion/models/review_model.dart';
import 'package:shop_fusion/screens/user_panel/all_Orders.dart';
import 'package:shop_fusion/screens/user_panel/main_screen.dart';
import 'package:shop_fusion/utils/compenents/custom_button.dart';
import 'package:uuid/uuid.dart';
class RatingScreen extends StatefulWidget {
  OrdersModel ordersModel;
   RatingScreen({super.key, required this.ordersModel});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  var uuid = Uuid();
  TextEditingController feedbackController=TextEditingController();
  double productRaiting=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Review'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
         const  Padding(
             padding:  EdgeInsets.all(8.0),
             child:   Text('Add your eating and review',style: TextStyle(fontSize: 17),),
           ),
      RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding:const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          productRaiting=rating;
        },
      ),
      const  SizedBox(height: 10,),
       const Text('Feedback',style: TextStyle(fontSize: 17),),
            SizedBox(height: Get.height*.05,),
            SizedBox(
              width: Get.width*.9,
              child: TextField(
                maxLines: null,
                controller: feedbackController,
                decoration:const InputDecoration(
                  label: Text('Share your feedback')
                ),
              ),
            ),
            SizedBox(height: Get.height*.03,),
            CustomButtom(voidCallback: () async {
              String id=uuid.v1();
              EasyLoading.show(status: 'Please wait..');
             String feedback=feedbackController.text.trim();
             if (kDebugMode) {
               print('$feedback\n$productRaiting');

               ReviewModel reviewModel=ReviewModel(
                   customerName: widget.ordersModel.customerName,
                   customerPhone: widget.ordersModel.customerPhone,
                   customerDeviceToken: widget.ordersModel.customerDeviceToken,
                   orderId: widget.ordersModel.ordersId,
                   customerProfilePic: widget.ordersModel.customerImg,
                   productId: widget.ordersModel.productId,
                   feedback: feedback,
                   rating: productRaiting.toString(),
                   createdAt: DateTime.now(),
               );
              try{
                await FirebaseFirestore.instance.collection('Reviews').
                doc(widget.ordersModel.productId).collection
                  ('allReviews').doc(id).set(reviewModel.toJson());
              }catch(e){
                print(e.toString());
              }
               EasyLoading.dismiss();
               Get.snackbar('Review', 'Thanks for the review ',
                 backgroundColor: Colors.black,
                 colorText: Colors.white,
                 snackPosition: SnackPosition.BOTTOM,

               );
             }
             Get.offAll(MainScreen());
            },
                title: 'Submit'),

          ],
        ),
      ),
    );
  }
}
