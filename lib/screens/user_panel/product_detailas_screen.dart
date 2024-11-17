import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'package:shop_fusion/utils/compenents/custom_button.dart';
import 'package:shop_fusion/utils/utils.dart';
class ProductDetailasScreen extends StatefulWidget {
  dynamic productDeatails;
   ProductDetailasScreen({super.key,required this.productDeatails});

  @override
  State<ProductDetailasScreen> createState() => _ProductDetailasScreenState();
}

class _ProductDetailasScreenState extends State<ProductDetailasScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Container(
               width: Get.width*1,
               height: Get.height/2,
               margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(9)
               ),
               child: CachedNetworkImage(
                 imageUrl: widget.productDeatails['productImages'],
                 progressIndicatorBuilder: (context, url, downloadProgress) =>
                     CircularProgressIndicator(value: downloadProgress.progress),
                 errorWidget: (context, url, error) => Icon(Icons.error),
               ),
             ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.productDeatails['productName']
                                ,style: const TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                           const Icon(Icons.favorite_outline_sharp)
                          ],
                        ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Rs ${widget.productDeatails['salePrice']}'
                          ,style: const TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('Description: ${widget.productDeatails['productDescription']}'
                        ,style: const TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                         SizedBox(
                           width:Get.width/3,
                           child: ElevatedButton(onPressed: (){},
                             style: ElevatedButton.styleFrom(
                               backgroundColor: AppConstant.appSecondryColor
                             ),
                               child: const Text('WhatsApp',
                                 style: TextStyle(color: Colors.white),)
                           ,),
                         ),
                        const  SizedBox(width: 3,),
                          SizedBox(
                            width:Get.width/3,
                            child: ElevatedButton(onPressed: (){
                                checkProductExistences(uId: user!.uid.toString());
                            },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppConstant.appSecondryColor
                              ),
                              child: const Text('Add to cart',
                                style: TextStyle(color: Colors.white),)
                              ,),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> checkProductExistences({required String uId,
    int quantityIncrement=1})
  async{
    try{
      DocumentReference documentReference=FirebaseFirestore.instance.
      collection('Carts').doc(uId).collection('cartOrders').
      doc(widget.productDeatails['productId'].toString());

      DocumentSnapshot documentSnapshot= await documentReference.get();
      if(documentSnapshot.exists)
      {
          int currentQuantity=documentSnapshot['productQuantity'];
          int updatedQuantity=currentQuantity+quantityIncrement;
          double totalPrice=double.parse(widget.productDeatails['fullPrice'])*updatedQuantity;
          await documentReference.update({
            'productQuantity':updatedQuantity,
            'productFullPrice':totalPrice
          });
          Utils.myFlushBar('This is already Added to your Cart', context);
      }else
      {

          await FirebaseFirestore.instance.collection('Carts').
          doc(uId).set({
            'createdAt':DateTime.now(),
            'uId':uId
          });

          CartModel cartModel=CartModel(
            createdAt: DateTime.now().toString(),
            deliveryTime: widget.productDeatails['deliveryTime'].toString(),
            fullPrice: int.parse(widget.productDeatails['fullPrice']),
            isSale: widget.productDeatails['isSale'],
            productDescription: widget.productDeatails['productDescription'].toString(),
            productId: widget.productDeatails['productId'].toString(),
            productImages: widget.productDeatails['productImages'].toString(),
            productName: widget.productDeatails['productName'].toString(),
            salePrice: widget.productDeatails['salePrice'].toString(),
            productQuantity: 1,
            productFullPrice:double.parse(widget.productDeatails['fullPrice']) ,
          );
          await documentReference.set(cartModel.toJson());

          Utils.myFlushBar('This is added to your cart', context);
        }


    } catch (e)
    {
      Utils.myFlushBar(e.toString(), context);
    }

  }

}
