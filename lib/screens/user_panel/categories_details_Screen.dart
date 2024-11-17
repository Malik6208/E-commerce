import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constant.dart';
import '../../utils/utils.dart';
class CategoriesDetailsScreen extends StatefulWidget {
  dynamic details;
   CategoriesDetailsScreen({super.key,required this.details});

  @override
  State<CategoriesDetailsScreen> createState() => _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState extends State<CategoriesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('CategoriesDetailsScreen'),
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
                imageUrl: widget.details['categoryImg'],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>const Icon(Icons.error),
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
                          Text(widget.details['categoryName']
                            ,style: const TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.favorite_outline_sharp)
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width:Get.width/3,
                              child: ElevatedButton(onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppConstant.appSecondryColor
                                ),
                                child: const Text('Add to cart',
                                  style: TextStyle(color: Colors.white),)
                                ,),
                            ),
                            const  SizedBox(width: 6,),
                            SizedBox(
                              width:Get.width/3,
                              child: ElevatedButton(onPressed: (){
                               
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

}
