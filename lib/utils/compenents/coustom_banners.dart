import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_fusion/controllres/firebase/banners_controller.dart';
class CoustomBanners extends StatefulWidget {
  const CoustomBanners({super.key});

  @override
  State<CoustomBanners> createState() => _CoustomBannersState();
}

class _CoustomBannersState extends State<CoustomBanners> {
  final CarouselController _carouselController=CarouselController();
  final BannerControllers _bannerControllers=Get.put(BannerControllers());
  @override
  Widget build(BuildContext context) {
    return Container(
             height: Get.height/3.5,
      padding: EdgeInsets.only(top: 10),
      child: Obx(() {
        return CarouselSlider(items:_bannerControllers.bannerUrls.map((imageUrls){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(imageUrl: imageUrls,
                fit: BoxFit.cover,width: Get.width*1,
                     height: Get.height/4,
              placeholder:(context, url) =>  const ColoredBox(color: Colors.white,child:Center(
                  child: CupertinoActivityIndicator()),),
                errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
              ),

            ),
          );
        }).toList(), options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 3.0,
          
        ),);
      },),
    );
  }
}
