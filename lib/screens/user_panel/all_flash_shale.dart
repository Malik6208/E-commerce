import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_fusion/screens/user_panel/product_detailas_screen.dart';

import '../../controllres/firebase/farebase_hepler.dart';
class AllFlashShale extends StatefulWidget {
  const AllFlashShale({super.key});

  @override
  State<AllFlashShale> createState() => _AllFlashShaleState();
}

class _AllFlashShaleState extends State<AllFlashShale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Flas Sale'),
      ),
      body:FutureBuilder(
        future: FirebaseFirestore.instance.collection('products')
            .where('isSale',isEqualTo: true).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: Get.height/5,
                child: const Center(child: CupertinoActivityIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ) {
            return const Center(child: Text('No Users Found'));
          }else{
            final docs = snapshot.data!.docs;
            return GridView.builder(
              itemCount: docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,mainAxisSpacing:2,
                  crossAxisSpacing: 2
              ),
              itemBuilder: (context, index) {
                var category=docs[index] ;
                return GestureDetector(
                  onTap: (){
                    Get.to(ProductDetailasScreen(productDeatails: category));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FillImageCard(

                      width: Get.width/2.4,
                      heightImage: Get.height/10,
                      borderRadius:20,
                      imageProvider:CachedNetworkImageProvider(
                        category['productImages'],
                      ),
                      title: Text(category['productName'].toString()),
                      //description: Text('data'),
                    ),
                  ),
                );

              },
            );
          }
        },
      ) ,
    );
  }
}
