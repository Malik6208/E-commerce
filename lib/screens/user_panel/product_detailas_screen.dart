import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_fusion/controllres/firebase/farebase_hepler.dart';
import 'package:shop_fusion/models/cart_model.dart';
import 'package:shop_fusion/models/review_model.dart';
import 'package:shop_fusion/models/user_model.dart';
import 'package:shop_fusion/utils/app_constant.dart';
import 'package:shop_fusion/utils/compenents/custom_button.dart';
import 'package:shop_fusion/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
class ProductDetailasScreen extends StatefulWidget {
  dynamic productDeatails;
   ProductDetailasScreen({super.key,required this.productDeatails});

  @override
  State<ProductDetailasScreen> createState() => _ProductDetailasScreenState();
}

class _ProductDetailasScreenState extends State<ProductDetailasScreen> {
   @override

  User? user=FirebaseAuth.instance.currentUser;
  UserModel? userModel;
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
                           child: ElevatedButton(onPressed: (){
                             sendMrssageOnWhatsapp();
                           },
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
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('Reviews')
                    .doc(widget.productDeatails['productId']).
                collection('allReviews').get(),

                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ) {
                  return const Center(child: Text('No Review found.'));
                 } else {

                    List<ReviewModel> documentData = snapshot.data!.docs.map((e) => ReviewModel.fromJson(e.data()) ).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documentData!.length,
                      itemBuilder: (context, index) {
                         ReviewModel reviewModel=documentData[index] ;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                          child: Card(elevation: 2,
                            child: ListTile(
                               leading: CircleAvatar(
                                 backgroundImage: NetworkImage(reviewModel.customerProfilePic),

                               ),
                              title:Text(reviewModel.customerName
                                ,style: const TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(reviewModel.feedback,style:
                              const TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold),),
                              trailing: Text(reviewModel.rating),
                            ),
                          ),
                        );
                      },);

                     }

                },),
          ],

        ),
      ),
    );
  }
  Future<void> sendMrssageOnWhatsapp()async{
    try{
      const number='+917321939626';
      final message='Hello can i help you\n regarding this product\n '
          '${widget.productDeatails['productName']}\n ${widget.productDeatails['fullPrice']}';
      final url='https://wa.me/$number?text=${Uri.encodeComponent(message)}';
      if(await canLaunch(url)){
        await launch(url);
      }
    }catch (e){
      if (kDebugMode) {
        print('Error while lunch url: ${e.toString()}');
      }
    }

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
